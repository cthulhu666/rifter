module Rifter
  module ShipModules
    class EnergyWeapon < ShipModule
      include Turret

      def infer_weapon_type
        # TODO
        case name
        when /beam/i
          'beam'
        when /pulse/i
          'pulse'
        else
          'unknown' # TODO
        end
      end
    end
  end
end
