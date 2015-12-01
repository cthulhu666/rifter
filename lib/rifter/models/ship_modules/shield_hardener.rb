module Rifter
  module ShipModules
    class ShieldHardener < ShipModule
      def setup(fitted_module)
        fitted_module['resistance_bonus'] = DAMAGE_TYPES.inject({}) do |h, dmg_type|
          h[dmg_type] = miscellaneous_attributes["#{dmg_type}_damage_resistance_bonus"]
          h
        end
      end
    end
  end
end
