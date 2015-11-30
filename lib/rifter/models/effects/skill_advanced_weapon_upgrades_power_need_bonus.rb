module Rifter
module Effects
  class SkillAdvancedWeaponUpgradesPowerNeedBonus < Effect

    description "Advanced Weapon Upgrades"

    def skill_effect(attrs, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') or m.item.skill_required?('Gunnery') },
        :power_usage,
        miscellaneous_attributes.power_need_bonus * skill_lvl
      )

    end
  end
end

end