module Rifter
  module Effects
    class ScriptMissileGuidanceComputerAOEVelocityBonusBonus < Effect
      description 'Missile Guidance Script'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.aoe_velocity_bonus *=
            1 + miscellaneous_attributes.aoe_velocity_bonus_bonus / 100.0
      end
    end
  end
end
