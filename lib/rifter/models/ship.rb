require 'digest/bubblebabble'

module Rifter
  class Ship
    include Mongoid::Document
    store_in collection: 'ships'

    ENABLED_GROUPS = [
        "Rookie ship", "Frigate", "Assault Frigate", "Destroyer",
        "Cruiser", "Attack Battlecruiser", "Combat Battlecruiser", "Command Ship",
        "Force Recon Ship", "Heavy Assault Cruiser", "Heavy Interdiction Cruiser",
        "Battleship"]

    FRIGATE_HULL = [/frigate/i, /destroyer/i, "Interceptor", "Electronic Attack Ship", "Stealth Bomber", "Rookie ship"]
    CRUISER_HULL = [/cruiser/i, "Combat Recon Ship", "Command Ship", "Force Recon Ship"]

    class Trait
      include Mongoid::Document

      embedded_in :ship, class_name: 'Rifter::Ship'

      field :bonus, type: Float
      field :bonus_text, type: String
      field :class_name, type: String

      belongs_to :skill, class_name: 'Rifter::Skill'

      class << self
        def setup
          Ship.each do |ship|
            ship.traits.each { |t| t.setup }
          end
        end
      end

      def setup
        digest = Digest::SHA256.bubblebabble(bonus_text)
        self.class_name = digest.split('-').map(&:capitalize).join
        save!
      end

      def trait
        @trait ||= begin
          Traits::const_get(class_name).new(bonus: bonus)
        rescue NameError => e
          #TODO: Rails.logger.error e
          nil
        end
      end
    end

    field :name, type: String
    field :group, type: String
    field :race, type: String

    field :power_output, type: Float
    field :cpu_output, type: Float

    field :lo_slots, type: Integer
    field :med_slots, type: Integer
    field :hi_slots, type: Integer
    field :rig_slots, type: Integer
    field :rig_size, type: Integer

    field :mass, type: Float
    field :volume, type: Float
    field :capacity, type: Float
    field :base_price, type: Float
    field :published, type: Boolean
    # TODO include EveItem

    # typeID in db dump
    field :type_id

    embeds_one :miscellaneous_attributes, class_name: 'Rifter::MiscellaneousAttributes'

    embeds_many :traits, class_name: 'Rifter::Ship::Trait'

    validates :name, :presence => true
    validates :group, :presence => true

    scope :group, ->(name) { where(:group.in => [name].flatten) }

    scope :meta_level, ->(l) { where('miscellaneous_attributes.meta_level' => l) }
    scope :tech_level, ->(l) { where('miscellaneous_attributes.tech_level' => l) }

    scope :published, -> { where(published: true) }
    default_scope -> { published }

    scope :frigates, -> { group('Frigate') }
    scope :cruisers, -> { group('Cruiser') }
    scope :battlecruisers, -> { group('Combat Battlecruiser') }
    scope :battleships, -> { group('Battleship') }

    %w(em thermal kinetic explosive).each do |dmg_type|
      delegate "shield_#{dmg_type}_damage_resonance", to: :miscellaneous_attributes
      delegate "armor_#{dmg_type}_damage_resonance", to: :miscellaneous_attributes
      delegate "#{dmg_type}_damage_resonance", to: :miscellaneous_attributes, prefix: :hull
    end

    %w(shield_capacity signature_radius armor_hp max_velocity agility
    capacitor_capacity upgrade_capacity drone_bandwidth drone_capacity).each do |s|
      delegate s, to: :miscellaneous_attributes
    end

    before_save do
      self.power_output = miscellaneous_attributes.power_output.to_f rescue 0
      self.cpu_output = miscellaneous_attributes.cpu_output.to_f rescue 0
      self.lo_slots = miscellaneous_attributes.low_slots.to_i rescue 0
      self.med_slots = miscellaneous_attributes.med_slots.to_i rescue 0
      self.hi_slots = miscellaneous_attributes.hi_slots.to_i rescue 0
      self.rig_slots = miscellaneous_attributes.rig_slots.to_i rescue 0
      self.rig_size = miscellaneous_attributes.rig_size.to_i rescue nil

    end

    class << self
      def random
        skip(rand(count)).first
      end

      # :)
      def caracal
        find_by(name: 'Caracal')
      end

      def kestrel
        find_by(name: 'Kestrel')
      end

      def average_target(group)
        @average_targets ||= Hash.new do |h, k|
          h[k] = _calculate_average_target(k)
        end
        @average_targets[group.to_s]
      end

      def _calculate_average_target(group)
        q = group(group)
        Hashie::Mash.new(
            signature_radius: q.map { |s| s.signature_radius }.mean,
            max_velocity: q.map { |s| s.max_velocity }.mean
        )
      end

      private :_calculate_average_target
    end

    def turret_slots
      miscellaneous_attributes.turret_slots_left.to_i
    end

    def launcher_slots
      # Naga doesn't have this attribute... maybe instead of checking this it's better to create this attribute in Importer
      if s = miscellaneous_attributes['launcher_slots_left']
        s.to_i
      else
        0
      end
    end

    def shield_recharge_rate
      miscellaneous_attributes.shield_recharge_rate / 1000.0
    end

    def recharge_rate
      miscellaneous_attributes.recharge_rate / 1000.0
    end

    def shield_resonances
      {
          em: shield_em_damage_resonance,
          thermal: shield_thermal_damage_resonance,
          kinetic: shield_kinetic_damage_resonance,
          explosive: shield_explosive_damage_resonance,
      }
    end

    def armor_resonances
      {
          em: armor_em_damage_resonance,
          thermal: armor_thermal_damage_resonance,
          kinetic: armor_kinetic_damage_resonance,
          explosive: armor_explosive_damage_resonance,
      }
    end

    def hull_resonances
      {
          em: hull_em_damage_resonance,
          thermal: hull_thermal_damage_resonance,
          kinetic: hull_kinetic_damage_resonance,
          explosive: hull_explosive_damage_resonance,
      }
    end

    def shield_resistances
      shield_resonances.inject({}) { |m, e| m[e.first] = 1 - e.last; m }
    end

    def hull_hp
      miscellaneous_attributes.hp
    end

    def weapon_types
      a = []
      a += turret_weapon_types if turret_slots > 0
      a += launcher_weapon_types if launcher_slots > 0
      a
    end

    def turret_weapon_types
      ["pulse", "beam", "autocannon", "artillery", "blaster", "railgun"]
    end

    def launcher_weapon_types
      case group
        when "Stealth Bomber"
          %w(missile_launcher_torpedo missile_launcher_bomb)
        when *FRIGATE_HULL
          %w(missile_launcher_rocket missile_launcher_light)
        when *CRUISER_HULL
          %w(missile_launcher_rocket missile_launcher_light missile_launcher_rapid_light
            missile_launcher_heavy missile_launcher_heavy_assault)
        else
          %w(missile_launcher_rocket missile_launcher_light missile_launcher_rapid_light
            missile_launcher_heavy missile_launcher_heavy_assault missile_launcher_cruise
            missile_launcher_torpedo missile_launcher_rapid_heavy)
      end
    end

    def validate_propulsion_mod_size(prop_mod, oversized: false)
      regex = case group
                when *FRIGATE_HULL
                  oversized ? /^(10|50)$/ : /^(1|5)$/
                when /cruiser/i, 'Industrial', 'Command Ship', 'Force Recon Ship'
                  oversized ? /^(100|500)$/ : /^(10|50)$/
                when "Battleship", "Black Ops"
                  /^(100|500)$/
                else
                  nil
              end
      (regex =~ prop_mod.name.match(/(\d{1,3})MN/)[1]) == 0
    end

    # TODO temporary; btw all (.*)_slots should be moved to ShipFiting because of T3 cruisers
    def drone_slots;
      5;
    end

    def scan_strength
      @scan_strength ||= ShipFitting::SCANNER_TYPE.inject({}) do |h, t|
        h[t] = miscellaneous_attributes["scan_#{t}_strength"]
        h
      end
    end

    def max_target_range
      miscellaneous_attributes.max_target_range
    end

  end
end
