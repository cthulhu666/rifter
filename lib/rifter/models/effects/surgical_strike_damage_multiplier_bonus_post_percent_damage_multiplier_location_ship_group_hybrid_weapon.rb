module Rifter
module Effects
  class SurgicalStrikeDamageMultiplierBonusPostPercentDamageMultiplierLocationShipGroupHybridWeapon < Effect

    description "Surgical Strike skill"

    def skill_effect(attrs, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.is_a?(ShipModules::HybridWeapon) },
        :damage_multiplier,
        miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
      )

    end

  end
end

end