module Rifter
  module Effects
    class ShieldOperationSkillBoostCapacitorNeedBonus < Effect
      description 'Shield Compensation skill; Core Defense Capacitor Safeguard rigs'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Shield Booster' },
          :capacitor_need,
          miscellaneous_attributes.shield_boost_capacitor_bonus
        )
      end

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Shield Booster' },
          :capacitor_need,
          skill_lvl * miscellaneous_attributes.shield_boost_capacitor_bonus
        )
      end
    end
  end
end
