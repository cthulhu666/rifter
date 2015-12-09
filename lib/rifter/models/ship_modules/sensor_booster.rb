module Rifter
  module ShipModules
    class SensorBooster < ShipModule
      include HasCharges

      copy_attributes :max_target_range_bonus, :scan_resolution_bonus
    end
  end
end
