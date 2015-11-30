module Rifter
  class Drone
    include Mongoid::Document
    store_in collection: 'drones'

    include EveItem
    include MarketData
    include RequiresSkills

    field :effects, type: Array, default: []
    field :drone_class, type: String

    scope :combat_drones, -> { group('Combat Drone') }

    class << self

      def classify_drones
        combat_drones.each do |d|
          drone_class =
              if d.miscellaneous_attributes.speed['max_velocity'] == 0
                'sentry'
              else
                case d.volume
                  when 5
                    :light
                  when 10
                    :medium
                  when 25
                    :heavy
                  # TODO: Gecko ?
                end
              end
          d.update_attribute(:drone_class, drone_class)
        end
      end

    end

    def drone_class
      ActiveSupport::StringInquirer.new(
          read_attribute(:drone_class)
      )
    end

    def setup(fitted_module)
      fitted_module.drone_bandwidth_used = miscellaneous_attributes.drones['drone_bandwidth_used']
      fitted_module.volume = volume
      fitted_module.damage = damage
      fitted_module.damage_multiplier = miscellaneous_attributes.turrets['damage_multiplier']
      class << fitted_module
        include FittedModuleInstanceMethods
      end
    end

    def damage
      h = Damage::DAMAGE_TYPES.inject({}) do |h, d|
        h[d] = miscellaneous_attributes.turrets["#{d}_damage"]
        h
      end
      Damage.new(h)
    end

    module FittedModuleInstanceMethods
      def volley
        damage * damage_multiplier
      end

      def rof
        (drone.miscellaneous_attributes.turrets['speed'] / 1000.0) ** -1
      end

      def dps
        volley * rof
      end
    end

  end
end
