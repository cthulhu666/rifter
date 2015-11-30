module Rifter
module Effects
  class EnergyGridUpgradesCpuNeedBonusPostPercentCpuLocationShipModulesRequiringEnergyGridUpgrades < Effect

    description "Powergrid Subroutine Maximizer rig; Energy Grid Upgrades skill"

    def effect(attrs, fitting:, fitted_module:)
     fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Energy Grid Upgrades')},
       :cpu_usage,
        miscellaneous_attributes.cpu_need_bonus
      )
    end

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Energy Grid Upgrades')},
        :cpu_usage,
        miscellaneous_attributes.cpu_need_bonus * skill_lvl
      )
    end
  end
end

end