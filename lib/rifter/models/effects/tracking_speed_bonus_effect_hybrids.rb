module Rifter
module Effects
  class TrackingSpeedBonusEffectHybrids < Effect

    description "Hybrid Metastasis Adjuster"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.is_a?(ShipModules::HybridWeapon) },
        :tracking_speed,
        miscellaneous_attributes.tracking_speed_bonus
      )
    end

  end
end

end