module Rifter
  module Effects
    class DroneDmgBonus < Effect
      description 'Various drone skills'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.drones.select { |m| m.drone.skill_required?(mod) }.each do |drone|
          drone.boost_attribute(
            :damage_multiplier,
            miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
          )
        end
      end
    end
  end
end
