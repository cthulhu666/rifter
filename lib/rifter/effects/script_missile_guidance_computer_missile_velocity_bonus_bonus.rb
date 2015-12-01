module Rifter
module Effects
  class ScriptMissileGuidanceComputerMissileVelocityBonusBonus < Effect

    description "Missile Guidance Script"

    def effect(attrs, fitting:, fitted_module:)
      fitted_module.missile_velocity_bonus *= 1 + miscellaneous_attributes.missile_velocity_bonus_bonus / 100.0
    end

  end
end

end