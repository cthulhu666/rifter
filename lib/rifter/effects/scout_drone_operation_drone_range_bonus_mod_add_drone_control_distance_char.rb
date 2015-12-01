module Rifter
  module Effects
    class ScoutDroneOperationDroneRangeBonusModAddDroneControlDistanceChar < Effect
      description 'Drone Control Range Augmentor rig, Drone Avionics skill'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :drone_control_range,
          miscellaneous_attributes.drone_range_bonus,
          type: :flat
        )
      end

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_attribute(
          :drone_control_range,
          miscellaneous_attributes.drone_range_bonus * skill_lvl,
          type: :flat
        )
      end
    end
  end
end
