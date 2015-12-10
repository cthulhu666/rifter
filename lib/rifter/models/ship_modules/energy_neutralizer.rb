module Rifter
  module ShipModules
    class EnergyNeutralizer < ShipModule
      copy_attributes :duration, :energy_destabilization_amount, :falloff_effectiveness,
                      :max_range, :capacitor_need
    end
  end
end
