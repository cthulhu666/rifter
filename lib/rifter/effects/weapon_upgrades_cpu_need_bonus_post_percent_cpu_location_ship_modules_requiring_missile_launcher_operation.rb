module Rifter
module Effects
  class WeaponUpgradesCpuNeedBonusPostPercentCpuLocationShipModulesRequiringMissileLauncherOperation < Effect

    description "Weapon Upgrades"

    def skill_effect(attrs, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Missile Launcher Operation') },
        :cpu_usage,
        miscellaneous_attributes.cpu_need_bonus * skill_lvl
      )

    end

  end
end

end