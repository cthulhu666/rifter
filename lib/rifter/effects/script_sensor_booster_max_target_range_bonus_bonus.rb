module Rifter
  module Effects
    class ScriptSensorBoosterMaxTargetRangeBonusBonus < Effect
      description 'Sensor Booster Script'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.max_target_range_bonus *= 1 + miscellaneous_attributes.max_target_range_bonus_bonus / 100.0
      end
    end
  end
end
