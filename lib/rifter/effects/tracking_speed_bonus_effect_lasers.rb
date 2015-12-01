module Rifter
module Effects
  class TrackingSpeedBonusEffectLasers < Effect

    description "Energy Metastasis Adjuster"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.is_a?(ShipModules::EnergyWeapon) },
        :tracking_speed,
        miscellaneous_attributes.tracking_speed_bonus
      )
    end

  end
end

end