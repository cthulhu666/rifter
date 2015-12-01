module Rifter
  module Effects
    class ScriptMissileGuidanceComputerExplosionDelayBonusBonus < Effect
      description 'Missile Guidance Script'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.explosion_delay_bonus *= 1 + miscellaneous_attributes.explosion_delay_bonus_bonus / 100.0
      end
    end
  end
end
