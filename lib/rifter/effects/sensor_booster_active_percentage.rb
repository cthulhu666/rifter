module Rifter
  module Effects
    class SensorBoosterActivePercentage < Effect
      description 'Sensor Booster modules'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :max_target_range,
          miscellaneous_attributes.max_target_range_bonus,
          stacking_penalty: true
        )
      end
    end
  end
end
