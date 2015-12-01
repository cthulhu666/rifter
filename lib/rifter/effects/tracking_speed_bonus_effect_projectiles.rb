module Rifter
  module Effects
    class TrackingSpeedBonusEffectProjectiles < Effect
      description 'Projectile Metastasis Adjuster'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.is_a?(ShipModules::ProjectileWeapon) },
          :tracking_speed,
          miscellaneous_attributes.tracking_speed_bonus
        )
      end
    end
  end
end
