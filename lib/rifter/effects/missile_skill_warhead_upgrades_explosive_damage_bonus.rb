module Rifter
  module Effects
    class MissileSkillWarheadUpgradesExplosiveDamageBonus < Effect
      description 'Skill: Warhead Upgrades'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.launchers.each do |m|
          m.alpha_dmg *= { explosive: 1.0 + (miscellaneous_attributes.damage_multiplier_bonus * skill_lvl / 100.0) }
        end
      end
    end
  end
end
