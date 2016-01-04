module Rifter
  module Effects
    class ScriptSensorBoosterScanResolutionBonusBonus < Effect
      description 'Sensor Booster Script'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.scan_resolution_bonus *=
            1 + miscellaneous_attributes.scan_resolution_bonus_bonus / 100.0
      end
    end
  end
end
