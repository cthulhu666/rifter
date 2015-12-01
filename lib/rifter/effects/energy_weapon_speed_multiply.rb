module Rifter
  module Effects
    class EnergyWeaponSpeedMultiply < Effect
      description 'Used by Heat Sink'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(ShipModules::EnergyWeapon) },
          :speed,
          miscellaneous_attributes.speed_multiplier,
          type: :multiplier,
          stacking_penalty: true
        )
      end
    end
  end
end
