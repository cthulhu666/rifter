module Rifter
module Effects
  class LargeEnergyTurretDamageMultiplierBonusPostPercentDamageMultiplierLocationShipModulesRequiringLargeEnergyTurret < Effect

    description 'Large Energy Turret skill'

    def skill_effect(attributes, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Large Energy Turret') },
        :damage_multiplier,
        miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
      )
    end

  end
end

end