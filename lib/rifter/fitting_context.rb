# frozen_string_literal: true
require 'matrix'
require 'ostruct'

module Rifter
  DAMAGE_TYPES = [:em, :thermal, :kinetic, :explosive].freeze

  class FittedModule < Struct.new(:ctx, :item, :idx)
    def attribute(id_or_name)
      id = id_or_name.is_a?(Fixnum) ? id_or_name : Attributes[id_or_name]
      ctx.module_attribute id, idx
    end

    def charge_attribute(id_or_name)
      id = id_or_name.is_a?(Fixnum) ? id_or_name : Attributes[id_or_name]
      ctx.charge_attribute id, idx
    end
  end

  module Turret
    DAMAGE_ACCESSORS = DAMAGE_TYPES.map { |d| "#{d}Damage" }.map { |d| -> (m) { m.charge_attribute(d) } }.freeze

    module_function

    def volley(mod)
      dmg_multiplier = mod.attribute('damageMultiplier')
      Vector[*DAMAGE_ACCESSORS.map { |a| a.call(mod) * dmg_multiplier }]
    end

    def dps(mod)
      volley = volley(mod)
      speed = mod.attribute('speed')
      rof = (speed / 1000.0)**-1
      volley * rof
    end
  end

  module Launcher
    DAMAGE_ACCESSORS = DAMAGE_TYPES.map { |d| "#{d}Damage" }.map { |d| -> (m) { m.charge_attribute(d) } }.freeze

    module_function

    def volley(mod)
      dmg_multiplier = mod.attribute('damageMultiplier')
      Vector[*DAMAGE_ACCESSORS.map { |a| a.call(mod) * dmg_multiplier }]
    end

    def dps(mod)
      volley = volley(mod)
      speed = mod.attribute('speed')
      rof = (speed / 1000.0)**-1
      volley * rof
    end
  end

  #   module Weapons
  #     class Turrets
  #       def initialize(ctx)
  #         @ctx = ctx
  #       end
  #     end
  #   end

  class ProtectionLayer
    attr_reader :ctx

    def initialize(ctx)
      @ctx = ctx
    end

    def resonances
      Vector[*resonance_accessors.map { |a| a.call(@ctx) }]
    end

    def resistances
      resonances.map { |r| 1.0 - r }
    end

    def effective_hp(damage_profile)
      capacity / resonances.zip(damage_profile.to_a).map { |a, b| a * b }.sum
    end

    # 'abstract' methods:
    def capacity
      fail NotImplementedError
    end

    def resonance_accessors
      fail NotImplementedError
    end

    protected :resonance_accessors
  end

  class Shield < ProtectionLayer
    RESONANCE_ACCESSORS = DAMAGE_TYPES
                          .map { |d| "shield#{d.capitalize}DamageResonance" }
                          .map { |a| -> (ctx) { ctx.ship_attribute(a) } }
                          .freeze

    def resonance_accessors
      RESONANCE_ACCESSORS
    end

    def capacity
      ctx.ship_attribute 'shieldCapacity'
    end
  end

  class Armor < ProtectionLayer
    RESONANCE_ACCESSORS = DAMAGE_TYPES
                          .map { |d| "armor#{d.capitalize}DamageResonance" }
                          .map { |a| -> (ctx) { ctx.ship_attribute(a) } }
                          .freeze

    def resonance_accessors
      RESONANCE_ACCESSORS
    end

    def capacity
      ctx.ship_attribute 'armorHP'
    end
  end

  class Structure < ProtectionLayer
    RESONANCE_ACCESSORS = DAMAGE_TYPES
                          .map { |d| "#{d}DamageResonance" }
                          .map { |a| -> (ctx) { ctx.ship_attribute(a) } }
                          .freeze

    def resonance_accessors
      RESONANCE_ACCESSORS
    end

    def capacity
      ctx.ship_attribute 'hp'
    end
  end

  class FittingContext
    attr_reader :modules

    def initialize(dogma_context)
      @ctx = dogma_context
      @modules = []
      @group_fitted = Hash.new { |h, k| h[k] = { max: 0, current: 0 } }
    end

    def ship=(item)
      fail "Ship expected, got: #{item.category}" unless item.category == 'Ship'
      @ctx.set_ship(item.type_id)
      @ship = item
    end

    def add_module(item, charge: nil, state: Dogma::STATE_ACTIVE)
      fail "Module or Subsystem expected, got: #{item.category}" unless item.category.in? %w(Module Subsystem)
      idx = @ctx.add_module(item.type_id, charge: charge&.type_id, state: state)
      @modules.push FittedModule.new(@ctx, item, idx).freeze
      check_max_group_fitted(item)
    end

    def check_max_group_fitted(item)
      if max = item.attributes['maxGroupFitted']&.value&.to_i
        h = @group_fitted[item.group]
        h[:max] = [h[:max], max].max # :)
        h[:current] += 1
      end
    end

    def ship_attribute(id_or_name)
      id = id_or_name.is_a?(Fixnum) ? id_or_name : Attributes[id_or_name]
      @ctx.ship_attribute id
    end

    def validate
      status = OpenStruct.new
      status.power = [power_left, 0].min
      status.cpu = [cpu_left, 0].min
      status.turrets = [ship_attribute('turretSlotsLeft'), 0].min
      status.launchers = [ship_attribute('launcherSlotsLeft'), 0].min
      status.max_group_fitted = 0
      @group_fitted.each_value do |v|
        status.max_group_fitted += [v[:max] - v[:current], 0].min
      end
      validate_rigs(status)
      if status.to_h.values.all? { |i| i == 0 }
        Deterministic::Result::Success status
      else
        Deterministic::Result::Failure status
      end
    end

    # TODO: can it be done on dogma level?
    def validate_rigs(status)
      status.wrong_size_rigs = 0
      rigs.each do |r|
        if r.attribute('rigSize') != ship_attribute('rigSize')
          status.wrong_size_rigs += 1
        end
      end
      calibration_used = rigs.inject(0) { |a, r| a + r.attribute('upgradeCost') }
      calibration_available = ship_attribute('upgradeCapacity')
      status.calibration = [0, calibration_available - calibration_used].min
    end

    def rigs
      @rigs ||= modules.select { |m| m.item.market_groups.include? 'Rigs' }
    end

    def shield
      @shield ||= Shield.new(self)
    end

    def armor
      @armor ||= Armor.new(self)
    end

    def structure
      @structure ||= Structure.new(self)
    end

    module BasicAttributes
      def power_left
        ship_attribute('powerOutput') - ship_attribute('powerLoad')
      end

      def cpu_left
        ship_attribute('cpuOutput') - ship_attribute('cpuLoad')
      end

      def turrets_volley
        turrets.map { |t| Turret.volley(t) }.inject(&:+)
      end

      def turrets_dps
        turrets.map { |t| Turret.dps(t) }.inject(&:+)
      end

      def launchers_volley
        launchers.map { |l| Launcher.volley(l) }.inject(&:+)
      end

      def launchers_dps
        launchers.map { |l| Launcher.dps(l) }.inject(&:+)
      end

      def effective_hp(damage_profile)
        [shield.effective_hp(damage_profile),
         armor.effective_hp(damage_profile),
         structure.effective_hp(damage_profile)].sum
      end
    end
    include BasicAttributes

    module ModuleFiltering
      def turrets
        modules.select do |m|
          m.item.required_skills.keys.include? Skills['Gunnery'].type_id
        end
      end

      def launchers
        modules.select do |m|
          m.item.required_skills.keys.include? Skills['Missile Launcher Operation'].type_id
        end
      end
    end
    include ModuleFiltering
  end
end
