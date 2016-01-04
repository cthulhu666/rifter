module Rifter
  module ShipModules
    class MissileGuidanceComputer < ShipModule
      include HasCharges

      copy_attributes :explosion_delay_bonus, :missile_velocity_bonus,
                      :aoe_velocity_bonus, :aoe_cloud_size_bonus
    end
  end
end
