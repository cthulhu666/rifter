module Rifter
  class ShipFitting
    POWER_TYPES = %i(lo med hi)

    SCANNER_TYPE = %i(magnetometric ladar radar gravimetric)

    DEFAULT_DAMAGE_PROFILE = DamageProfile.new(em: 25, thermal: 25, kinetic: 25, explosive: 25)

    PEAK_RECHARGE = 0.25

    include Modifiers

    attr_reader :ship, :character, :miscellaneous_attributes, :modifiers

    def initialize(ship:, character:)
      @ship = ship
      @character = character
      @fitted_modules = []
      @fitted_drones = []
      @modifiers = []
      @miscellaneous_attributes = MiscAttributes.new
      empty
    end

    class MiscAttributes < Hash
      include Hashie::Extensions::MethodAccess
    end

    class FittedDrone
      include Modifiers

      attr_accessor :drone, :damage, :damage_multiplier, :volume, :drone_bandwidth_used, :modifiers

      def initialize(drone: nil)
        @id = SecureRandom.uuid
        @drone = drone
        @modifiers = []
      end

      def setup
        drone.setup(self)
      end
    end

    class FittedModule < Hash
      include Hashie::Extensions::MethodAccess
      include Hashie::Extensions::IndifferentAccess
      include Modifiers

      # TODO: to nie jest zbyt fajne, bo np. omyłkową zamiast na ShipModule wołałem #skill_required? i dostawałem false!
      # trzeba w #setup_module jakoś definiować atrybuty i to musi być zamknięta lista

      attr_reader :ship_module, :power, :id, :modifiers
      attr_writer :ship_module

      # TODO: make it generic and use items instead of ship_modules
      alias_method :item, :ship_module

      def initialize(ship_module: nil, power:)
        @id = SecureRandom.uuid
        @ship_module = ship_module
        @power = power
        self.cpu_usage = 0
        self.power_usage = 0
        @modifiers = []
      end

      def to_s
        "#{power}:#{ship_module.try :name}"
      end

      def inspect
        to_s
      end

      def type_id
        ship_module.try(:type_id)
      end

      def setup
        self.cpu_usage = ship_module.cpu
        self.power_usage = ship_module.power
        ship_module.setup(self) if ship_module.respond_to?(:setup)
      end

      def effect(*args)
        charge.effect(*args) if respond_to?(:charge)
        ship_module.effect(*args) if ship_module
      end

      def try_charge(charge)
        unless item.nil?
          self.charge = charge if item.respond_to?(:charges) && item.charge_valid?(charge)
        end
      end
    end

    def fitted_modules(klass: nil, type: nil)
      mods = @fitted_modules.dup
      unless klass.nil?
        klass = [klass].flatten
        mods.keep_if do |m|
          klass.any? { |k| m.ship_module.is_a?(k) }
        end
      end
      unless type.nil?
        type = [type].flatten
        mods.keep_if do |m|
          type.any? { |k| m.power == k }
        end
      end
      mods
    end

    def validate_skills
      # TODO: cache results for modules
      all_modules.inject([]) do |arr, m|
        arr << m.validate_skills(character.skills_map)
        arr.flatten
      end
    end

    def validate_constraints(constraints = [])
      @fitting_errors = 0

      @fitting_errors += max_group_fitted
      @fitting_errors += validate_weapons
      @fitting_errors += validate_calibration
      @fitting_errors += validate_skills.size
      @fitting_errors += power_shortage + cpu_shortage
      @fitting_errors += validate_charges
      @fitting_errors += validate_drone_bandwidth
      @fitting_errors += validate_drone_skills

      @fitting_errors +=
          constraints.size - constraints.count { |c| c.evaluate(self) == 0 }

      # TODO: we dont really care about the sum, so just break on first 'breach'

      @fitting_errors
    end

    def validate_drone_bandwidth
      [0, drone_bandwidth_shortage].max
    end

    def validate_drone_skills
      [0, drones.size - max_active_drones].max
    end

    def drone_bandwidth
      miscellaneous_attributes.drone_bandwidth
    end

    def drone_bandwidth_used
      drones.inject(0) { |sum, d| sum += d.drone_bandwidth_used }
    end

    def validate_charges
      fitted_modules.inject(0) do |sum, fm|
        if fm.respond_to?(:charge) && fm.ship_module.respond_to?(:charges)
          if c = fm.charge
            sum += 1 unless fm.ship_module.charge_valid?(c)
          end
        end
        sum
      end
    end

    def max_group_fitted
      all_modules.inject(0) do |errors, mod|
        if max = mod.miscellaneous_attributes.try(:max_group_fitted)
          errors += 1 if all_modules.count { |m| m.group == mod.group } > max
        end
        errors
      end
    end

    def validate_weapons
      [0, turret_slots_left].min.abs + [0, launcher_slots_left].min.abs
    end

    # TODO: this isn't really necessary, because only rigs of proper size are fitted
    def validate_rigs
      rigs.inject(0) do |sum, r|
        sum += 1 unless r.rig_size.to_i == ship.rig_size.to_i
        sum
      end
    end

    def validate_calibration
      [calibration, 0].min.abs
    end

    def calibration
      ship.upgrade_capacity - rigs.inject(0) { |sum, rig| sum += rig.upgrade_cost; sum }
    end

    def turret_slots
      ship.turret_slots
    end

    def turret_slots_left
      ship.turret_slots - all_modules(Turret).size
    end

    def launcher_slots
      ship.launcher_slots
    end

    def launcher_slots_left
      ship.launcher_slots - all_modules(Launcher).size
    end

    def launchers
      fitted_modules(klass: Launcher)
    end

    def turrets
      fitted_modules(klass: Turret)
    end

    def weapons
      turrets + launchers
    end

    def propulsion_mods(type = nil)
      prop_mods = fitted_modules(klass: ShipModules::PropulsionModule)
      case type
      when nil
      # noop
      when :afterburner
        prop_mods.keep_if { |p| p.ship_module.name =~ /Afterburner/ }
      when :microwarpdrive
        prop_mods.keep_if { |p| p.ship_module.name =~ /Microwarpdrive/ }
      else
        fail ArgumentError, "#{type} not allowed, allowed types are :afterburner, :microwarpdrive"
      end
      prop_mods
    end

    def rigs
      # TODO: refactor using fitted_modules(klass:, type:)
      @fitted_modules.select { |m| m.power.to_sym == :rig && m.ship_module.is_a?(Rig) }
    end

    # stats

    def power_usage
      miscellaneous_attributes.power_usage
    end

    def power_shortage
      [power_usage - power_output, 0].max
    end

    def cpu_usage
      miscellaneous_attributes.cpu_usage
    end

    def cpu_shortage
      [cpu_usage - cpu_output, 0].max
    end

    def cpu_output
      miscellaneous_attributes.cpu_output
    end

    def power_output
      miscellaneous_attributes.power_output
    end

    def drone_bandwidth_usage
      miscellaneous_attributes.drone_bandwidth_usage
    end

    def drone_bandwidth_shortage
      [drone_bandwidth_usage - drone_bandwidth, 0].max
    end

    def drones
      @fitted_drones.select(&:drone)
    end

    def drone_slots
      @fitted_drones
    end

    def mass
      miscellaneous_attributes.mass
    end

    def max_velocity(propulsion_module_in_use = nil)
      case propulsion_module_in_use
      when nil
        miscellaneous_attributes.max_velocity
      when :afterburner
        if ab = propulsion_mods(:afterburner).first
          thrust = ab.speed_boost_factor
          miscellaneous_attributes.max_velocity * (1.0 + ab.speed_factor * thrust / mass / 100.0)
        end
      when :microwarpdrive
        if mwd = propulsion_mods(:microwarpdrive).first
          thrust = mwd.speed_boost_factor
          miscellaneous_attributes.max_velocity * (1.0 + mwd.speed_factor * thrust / mass / 100.0)
        end
      end
    end

    def agility
      miscellaneous_attributes.agility
    end

    # BEGIN shields

    def shield_capacity
      miscellaneous_attributes.shield_capacity
    end

    %i(shield armor hull).each do |s|
      define_method "#{s}_hp" do |damage_profile: DEFAULT_DAMAGE_PROFILE|
        damage_profile = DamageProfile.new(damage_profile) unless damage_profile.is_a?(DamageProfile)
        cap = miscellaneous_attributes["#{s}_capacity"]
        res = miscellaneous_attributes["#{s}_resonances"]
        cap / damage_profile.to_a.inject(0) { |sum, e| sum += e.last * res[e.first] }
      end

      define_method "#{s}_resistances" do
        miscellaneous_attributes["#{s}_resonances"].inject({}) { |m, e| m[e.first] = (1 - e.last).round(3); m }
      end
    end

    def shield_recharge_rate
      miscellaneous_attributes.shield_recharge_rate
    end

    def signature_radius
      miscellaneous_attributes.signature_radius
    end

    def base_shield_hp_per_sec
      shield_capacity / shield_recharge_rate
    end

    # per sec
    def shield_boost
      miscellaneous_attributes.shield_boost
    end

    def effective_shield_boost(damage_profile: DEFAULT_DAMAGE_PROFILE)
      damage_profile = DamageProfile.new(damage_profile) unless damage_profile.is_a?(DamageProfile)
      res = miscellaneous_attributes.shield_resonances
      shield_boost / damage_profile.to_a.inject(0) { |sum, e| sum += e.last * res[e.first] }
    end

    # END shields

    # BEGIN armor

    def armor_capacity
      miscellaneous_attributes.armor_capacity
    end

    # END armor

    # BEGIN hull

    def hull_capacity
      miscellaneous_attributes.hull_capacity
    end

    # END hull

    def effective_hp(damage_profile: DEFAULT_DAMAGE_PROFILE)
      %i(shield_hp armor_hp hull_hp).map do |method_name|
        send method_name, damage_profile: damage_profile
      end.inject(:+)
    end

    def capacitor_capacity
      miscellaneous_attributes.capacitor_capacity
    end

    # BEGIN weapons

    def missile_alpha
      launchers.inject(Damage.new) { |sum, l| sum += l.volley }
    end

    def missile_dps
      launchers.select { |l| l['charge'] }.inject([Damage.new, Damage.new]) do |d, l|
        dps = l.dps
        d[0] += dps.first
        d[1] += dps.last
        d
      end
    end

    def turrets_volley
      turrets.inject(Damage.new) { |sum, t| sum += t.volley }
    end

    def turrets_dps
      turrets.inject(Damage.new) { |sum, t| sum += t.dps }
    end

    # END weapons

    # bool

    def has_point?
      all_modules.any? { |m| m.group == 'Warp Scrambler' }
    end

    def has_prop?
      all_modules.any? { |m| m.group == 'Propulsion Module' }
    end

    def fit_module(mod, slot: nil)
      case mod
      when String, Regexp
        mod = ShipModule[mod]
      end
      slot ||= mod.slot
      if fm = fitted_modules.find { |m| m.power == slot.to_sym && m.ship_module.nil? }
        fm.ship_module = mod
      else
        fail 'No slots available'
      end
      fm
    end

    def fit_drone(drone)
      case drone
      when String, Regexp
        drone = Drone.find_by(name: drone)
      end
      if slot = drone_slots.find { |s| s.drone.nil? }
        slot.drone = drone
      else
        fail 'No slots available'
      end
    end

    def all_modules(type = nil)
      all = fitted_modules.map(&:ship_module)
      all.keep_if { |m| m.is_a?(type) } unless type.nil?
      all.compact
    end

    # TODO: rename to setup_slots or sth
    def empty
      ship.hi_slots.times { @fitted_modules << FittedModule.new(power: :hi) }
      ship.med_slots.times { @fitted_modules << FittedModule.new(power: :med) }
      ship.lo_slots.times { @fitted_modules << FittedModule.new(power: :lo) }
      ship.rig_slots.times { @fitted_modules << FittedModule.new(power: :rig) }
      # TODO: according to skill and modules(carriers etc)
      5.times { @fitted_drones << FittedDrone.new }
    end

    private :empty

    def calculate_effects
      setup_miscellaneous_attributes
      run_effects
      apply_all_modifiers

      miscellaneous_attributes['cpu_usage'] = fitted_modules.inject(0) { |sum, m| sum += m.cpu_usage; sum }
      miscellaneous_attributes['power_usage'] = fitted_modules.inject(0) { |sum, m| sum += m.power_usage; sum }
      miscellaneous_attributes['drone_bandwidth_usage'] = drones.inject(0) { |sum, m| sum += m.drone_bandwidth_used; sum }
      # freeze
    end

    def apply_all_modifiers
      @fitted_modules.each { |fm| fm.apply_modifiers if fm.item }
      @fitted_drones.each { |d| d.apply_modifiers if d.drone }
      apply_modifiers(miscellaneous_attributes)
    end

    def run_effects
      ship.traits.each do |trait|
        # We need to process this even when no skill present because of 'role traits' (skill independent)
        skill_lvl = trait.skill ? character.skill_level(trait.skill) : 1
        if t = trait.trait and t.respond_to?(:effect)
          t.effect(fitting: self, skill_lvl: skill_lvl)
        end
      end

      # TODO: calculate skill effects once, and store results in ShipModule/Ship directly
      character.relevant_character_skills.each do |char_skill|
        char_skill.effect(miscellaneous_attributes, fitting: self)
      end

      # TODO: don't pass miscellaneous_attributes
      fitted_modules.each { |m| m.effect(miscellaneous_attributes, fitting: self, fitted_module: m) }
    end

    def setup_miscellaneous_attributes
      @miscellaneous_attributes = MiscAttributes.new

      all_modules.each(&:freeze) # TODO: not necessary
      fitted_modules.each { |m| m.setup if m.ship_module.present? }
      drones.each(&:setup)

      miscellaneous_attributes['shield_capacity'] = ship.shield_capacity
      miscellaneous_attributes['armor_capacity'] = ship.armor_hp
      miscellaneous_attributes['hull_capacity'] = ship.hull_hp
      miscellaneous_attributes['shield_recharge_rate'] = ship.shield_recharge_rate
      miscellaneous_attributes['shield_boost'] = 0

      miscellaneous_attributes['shield_resonances'] = ship.shield_resonances
      miscellaneous_attributes['armor_resonances'] = ship.armor_resonances
      miscellaneous_attributes['hull_resonances'] = ship.hull_resonances

      miscellaneous_attributes['max_velocity'] = ship.max_velocity
      miscellaneous_attributes['agility'] = ship.agility
      miscellaneous_attributes['mass'] = ship.mass
      miscellaneous_attributes['signature_radius'] = ship.signature_radius
      miscellaneous_attributes['capacitor_capacity'] = ship.capacitor_capacity
      miscellaneous_attributes['recharge_rate'] = ship.recharge_rate

      miscellaneous_attributes['cpu_output'] = ship.cpu_output
      miscellaneous_attributes['power_output'] = ship.power_output

      miscellaneous_attributes['drone_bandwidth'] = ship.drone_bandwidth
      miscellaneous_attributes['drone_capacity'] = ship.drone_capacity
      miscellaneous_attributes['drone_dps'] = Damage.new
      miscellaneous_attributes['drone_control_range'] = 20_000
      miscellaneous_attributes['max_active_drones'] = 0

      miscellaneous_attributes['max_target_range'] = ship.max_target_range

      SCANNER_TYPE.each do |t|
        miscellaneous_attributes["#{t}_strength"] = ship.scan_strength[t]
      end

      self
    end

    def price
      all_modules.map(&:avg_sell_price).sum || 0
    end

    def boost_module_attribute(filter, name, value, type: :percent, stacking_penalty: false, nested_property: nil)
      @fitted_modules.select { |e| e.item && filter.call(e) }.each_with_index do |fm, _i|
        fm.boost_attribute(name, value, type: type, stacking_penalty: stacking_penalty, nested_property: nested_property)
      end
    end

    # https://github.com/DarkFenX/Pyfa/blob/b2dce223b0a621678777a7bcf2a395e70b0fa6cc/eos/saveddata/fit.py#L811
    def shield_recharge(percent = PEAK_RECHARGE)
      recharge_rate = miscellaneous_attributes.shield_recharge_rate
      10 / recharge_rate * (percent**0.5) * (1 - (percent**0.5)) * shield_capacity
    end

    def shield_tank(damage_profile: DEFAULT_DAMAGE_PROFILE)
      damage_profile = DamageProfile.new(damage_profile) unless damage_profile.is_a?(DamageProfile)
      res = miscellaneous_attributes['shield_resonances']
      shield_recharge / damage_profile.to_a.inject(0) { |sum, e| sum += e.last * res[e.first] }
    end

    def drone_dps
      drones.inject(Damage.new) { |dmg, d| dmg += d.dps; dmg }
    end

    def drone_control_range
      miscellaneous_attributes.drone_control_range
    end

    def max_active_drones
      miscellaneous_attributes.max_active_drones
    end

    def cap_recharge(percent = PEAK_RECHARGE)
      recharge_rate = miscellaneous_attributes.recharge_rate
      10 / recharge_rate * (percent**0.5) * (1 - (percent**0.5)) * capacitor_capacity
    end

    def inspect
      "#<#{self.class} ship: #{ship.name}, mods: #{fitted_modules}, price: #{(price / 10**6).round}M>"
    end

    def scan_strength
      SCANNER_TYPE.map { |t| miscellaneous_attributes["#{t}_strength"] }.max
    end

    def probe_size
      # TODO: check this
      probe_size = signature_radius / scan_strength
    end

    def align_time
      -Math.log(0.25) * agility * mass / 1_000_000.0
    end

    def max_target_range
      miscellaneous_attributes.max_target_range
    end

    def weapon_range
      t = turrets.map { |t| t.optimal + t.falloff }
      l = launchers.map(&:range)
      [t.max, l.max].compact.max.try(:round)
    end

    def missile_damage_projection(target: nil, group: nil)
      fail ArgumentError, 'Target or Group required' if [target, group].compact.empty?
      target = Ship.average_target(group) if group
      launchers.inject(Damage.new) do |dmg, l|
        dmg += l.dps.first.calculate_missile_damage(launcher: l, target: target)
        dmg
      end
    end

    def turret_damage_projection(target: nil, group: nil, distance: nil)
      fail ArgumentError, 'Target or Group required' if [target, group].compact.empty?
      target = Ship.average_target(group) if group
      turrets.inject(Damage.new) do |dmg, t|
        distance ||= t.optimal + t.falloff / 2
        dmg += t.dps.calculate_turret_damage(turret: t, target: target, distance: distance, angle: 90, velocity: target.max_velocity)
        dmg
      end
    end

    def target_painter_effect(target:, distance:)
      fitted_modules(klass: ShipModules::TargetPainter).each do |tp|
        target.boost_attribute(:signature_radius, tp.signature_radius_bonus, stacking_penalty: true)
      end
      target.apply_modifiers
      # range_eq = (([0, distance - optimal].max) / falloff) ** 2
      # 0.5 ** (tracking_eq + range_eq)
    end
  end
end
