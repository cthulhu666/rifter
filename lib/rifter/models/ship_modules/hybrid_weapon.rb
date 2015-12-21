module Rifter
  module ShipModules
    class HybridWeapon < ShipModule
      include Turret

      copy_attributes :capacitor_need

      def infer_weapon_type
        ratio = miscellaneous_attributes[:max_range] / miscellaneous_attributes[:falloff]
        case ratio
        when 0..1
          'blaster'
        else
          'railgun'
        end
      end
    end
  end
end
