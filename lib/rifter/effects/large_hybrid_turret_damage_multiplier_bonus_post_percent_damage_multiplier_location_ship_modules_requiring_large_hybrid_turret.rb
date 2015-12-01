module Rifter
  module Effects
    class LargeHybridTurretDamageMultiplierBonusPostPercentDamageMultiplierLocationShipModulesRequiringLargeHybridTurret < Effect
      description 'Large Hybrid Turret skill'

      def skill_effect(_attributes, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Hybrid Turret') },
          :damage_multiplier,
          miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
        )
      end
    end
  end
end
