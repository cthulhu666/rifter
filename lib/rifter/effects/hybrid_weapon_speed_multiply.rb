module Rifter
module Effects
  class HybridWeaponSpeedMultiply < Effect

    description "Used by Magnetic Field Stabilizer"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
      -> (m) { m.ship_module.is_a?(ShipModules::HybridWeapon) },
        :speed,
        miscellaneous_attributes.speed_multiplier,
        type: :multiplier,
        stacking_penalty: true,
      )
    end

  end
end

end