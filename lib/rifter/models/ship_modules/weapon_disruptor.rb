module Rifter
  module ShipModules
    class WeaponDisruptor < ShipModule

      copy_attributes :max_range, :missile_velocity_bonus, :explosion_delay_bonus,
                      :aoe_velocity_bonus, :aoe_cloud_size_bonus

    end
  end
end
