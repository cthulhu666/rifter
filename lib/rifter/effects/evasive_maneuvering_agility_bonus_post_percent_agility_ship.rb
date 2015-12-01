module Rifter
  module Effects
    class EvasiveManeuveringAgilityBonusPostPercentAgilityShip < Effect
      description 'Evasive Maneuvering, Spaceship Command skills; Rig Anchor'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :agility,
          miscellaneous_attributes.agility_bonus,
          stacking_penalty: true
        )
      end

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_attribute(:agility, miscellaneous_attributes.agility_bonus * skill_lvl)
      end
    end
  end
end
