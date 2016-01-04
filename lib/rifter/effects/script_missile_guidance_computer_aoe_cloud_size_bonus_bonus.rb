module Rifter
  module Effects
    class ScriptMissileGuidanceComputerAOECloudSizeBonusBonus < Effect
      description 'Missile Guidance Script'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.aoe_cloud_size_bonus *=
            1 + miscellaneous_attributes.aoe_cloud_size_bonus_bonus / 100.0
      end
    end
  end
end
