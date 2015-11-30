module Rifter
module Effects
  class KineticShieldCompensationHardeningBonusGroupShieldAmp < Effect

    description "Kinetic Shield Compensation skill"

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.is_a?(ShipModules::ShieldAmplifier) },
        :resistance_bonus,
        miscellaneous_attributes.hardening_bonus * skill_lvl,
        nested_property: :kinetic
      )
    end

  end
end

end