module Rifter
module Effects
  class ExplosiveArmorCompensationHardeningBonusGroupEnergized < Effect

    description "Explosive Armor Compensation skill"

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.is_a?(ShipModules::ArmorPlatingEnergized) },
        :resistance_bonus,
        miscellaneous_attributes.hardening_bonus * skill_lvl,
        nested_property: :explosive
      )
    end

  end
end

end