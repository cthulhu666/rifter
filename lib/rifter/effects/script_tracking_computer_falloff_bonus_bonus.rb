module Rifter
module Effects
  class ScriptTrackingComputerFalloffBonusBonus < Effect

    description "Tracking Script"

    def effect(attrs, fitting:, fitted_module:)
      fitted_module.falloff_bonus *= 1 + miscellaneous_attributes.falloff_bonus_bonus / 100.0
    end

  end
end

end