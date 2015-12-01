module Rifter
  module ShipModules
    class TrackingComputer < ShipModule
      include HasCharges

      def setup(fitted_module)
        %i(max_range_bonus falloff_bonus).each do |s|
          fitted_module[s] = miscellaneous_attributes[s]
        end
      end
    end
  end
end
