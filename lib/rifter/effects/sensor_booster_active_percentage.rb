module Rifter
  module Effects
    class SensorBoosterActivePercentage < Effect
      description 'Sensor Booster modules'

      def effect(_attrs, fitting:, fitted_module:)
        # TODO: scan resolution
        [%i(max_target_range max_target_range_bonus)].each do |k, v|
          fitting.boost_attribute(
            k,
            fitted_module[v],
            stacking_penalty: true
          )
        end
      end
    end
  end
end
