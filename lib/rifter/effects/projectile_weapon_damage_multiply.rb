module Rifter
module Effects
  class ProjectileWeaponDamageMultiply < Effect

    description "Used by Gyrostabilizer"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.is_a?(ShipModules::ProjectileWeapon) },
        :damage_multiplier,
        miscellaneous_attributes.damage_multiplier,
        type: :multiplier,
        stacking_penalty: true,
      )
    end

  end
end

end