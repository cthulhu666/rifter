module Rifter
  module Effects
    class EmShieldCompensationHardeningBonusGroupShieldAmp < Effect
      description 'EM Shield Compensation skill'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.is_a?(ShipModules::ShieldAmplifier) },
          :resistance_bonus,
          miscellaneous_attributes.hardening_bonus * skill_lvl,
          nested_property: :em
        )
      end
    end
  end
end
