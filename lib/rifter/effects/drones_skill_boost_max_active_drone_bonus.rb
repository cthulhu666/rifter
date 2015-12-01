module Rifter
  module Effects
    class DronesSkillBoostMaxActiveDroneBonus < Effect
      description 'Drones skill'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_attribute(
          :max_active_drones,
          miscellaneous_attributes.max_active_drone_bonus * skill_lvl,
          type: :flat
        )
      end
    end
  end
end
