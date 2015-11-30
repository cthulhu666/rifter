module Rifter
module Effects
  class MaxRangeBonusEffectProjectiles < Effect

    description "Projectile Locus Coordinator"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.is_a?(ShipModules::ProjectileWeapon) },
        :optimal,
        miscellaneous_attributes.max_range_bonus,
        stacking_penalty: true,
      )
    end

  end
end

end