module Rifter
  module Effects
    class MaxRangeBonusEffectHybrids < Effect
      description 'Hybrid Locus Coordinator'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(ShipModules::HybridWeapon) },
          :optimal,
          miscellaneous_attributes.max_range_bonus,
          stacking_penalty: true
        )
      end
    end
  end
end
