module Rifter
  module ShipModules
    class EnergyWeapon < ShipModule
      include Turret

      copy_attributes :capacitor_need

      def infer_weapon_type
        case name
        when /beam/i
          'beam'
        when /pulse/i
          'pulse'
        else
          nil
        end
      end
    end
  end
end
