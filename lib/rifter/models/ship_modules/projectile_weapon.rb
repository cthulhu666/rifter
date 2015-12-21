module Rifter
  module ShipModules
    class ProjectileWeapon < ShipModule
      include Turret

      copy_attributes :capacitor_need

      def infer_weapon_type
        # TODO: https://wiki.eveonline.com/en/wiki/Projectile_turret
        ratio = miscellaneous_attributes[:max_range] / miscellaneous_attributes[:falloff]
        case ratio
        when 0..(0.5)
          'autocannon'
        else
          'artillery'
        end
      end
    end
  end
end
