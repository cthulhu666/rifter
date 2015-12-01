module Rifter
  module Effects
    class DroneDamageBonusRequringDrones < Effect
      description 'Skill: Drone Interfacing'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.drones.each do |drone|
          drone.boost_attribute(
            :damage_multiplier,
            miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
          )
        end
      end
    end
  end
end
