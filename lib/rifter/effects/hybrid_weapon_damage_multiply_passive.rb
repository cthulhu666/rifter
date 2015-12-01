module Rifter
  module Effects
    class HybridWeaponDamageMultiplyPassive < Effect
      description 'Hybrid Collision Accelerator'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(ShipModules::HybridWeapon) },
          :damage_multiplier,
          miscellaneous_attributes.damage_multiplier,
          type: :multiplier,
          stacking_penalty: true
        )
      end
    end
  end
end
