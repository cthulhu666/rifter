module Rifter
  module ShipModules
    class SensorBooster < ShipModule
      include HasCharges

      def setup(fitted_module)
        fitted_module['max_target_range_bonus'] = miscellaneous_attributes['max_target_range_bonus']
      end
    end
  end
end
