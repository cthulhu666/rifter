module Rifter
  module ShipModules
    class EnergyNosferatu < ShipModule

      copy_attributes :duration, :power_transfer_amount, :falloff_effectiveness,
                      :max_range, :capacitor_need

    end
  end
end
