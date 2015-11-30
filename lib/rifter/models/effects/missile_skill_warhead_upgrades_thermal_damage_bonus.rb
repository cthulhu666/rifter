module Rifter
module Effects
  class MissileSkillWarheadUpgradesThermalDamageBonus < Effect

    description 'Skill: Warhead Upgrades'

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.launchers.each do |m|
        m.alpha_dmg *= {:thermal => 1.0 + (miscellaneous_attributes.damage_multiplier_bonus * skill_lvl / 100.0)}
      end
    end

  end
end

end