module Rifter
  module Effects
    class ScriptTrackingComputerMaxRangeBonusBonus < Effect
      description 'Tracking Script'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.max_range_bonus *= 1 + miscellaneous_attributes.max_range_bonus_bonus / 100.0
      end
    end
  end
end
