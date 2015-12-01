module Rifter
  module Effects
    class EnergyWeaponSpeedMultiplyPassive < Effect
      description 'Energy Burst Aerator'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(ShipModules::ProjectileWeapon) },
          :speed,
          miscellaneous_attributes.speed_multiplier,
          type: :multiplier,
          stacking_penalty: true
        )
      end
    end
  end
end
