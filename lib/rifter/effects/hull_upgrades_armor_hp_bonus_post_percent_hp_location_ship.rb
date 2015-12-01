module Rifter
module Effects
  class HullUpgradesArmorHpBonusPostPercentHpLocationShip < Effect

    description "Skill: Hull Upgrades"

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_attribute(
                 :armor_capacity,
                 miscellaneous_attributes.armor_hp_bonus * skill_lvl
      )
    end
  end
end

end