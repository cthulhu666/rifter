module Rifter
  module Effects
    class MissileDMGBonusPassive < Effect
      description 'Warhead Calefaction Catalyst rigs'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.launchers.each do |l|
          l.boost_attribute(
            :alpha_dmg,
            miscellaneous_attributes.missile_damage_multiplier_bonus,
            type: :multiplier,
            stacking_penalty: true
          )
        end
      end
    end
  end
end
