module Rifter
  module Effects
    class ProjectileWeaponDamageMultiplyPassive < Effect
      description 'Projectile Collision Accelerator'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(ShipModules::ProjectileWeapon) },
          :damage_multiplier,
          miscellaneous_attributes.damage_multiplier,
          type: :multiplier,
          stacking_penalty: true
        )
      end
    end
  end
end
