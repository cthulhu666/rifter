module Rifter
  module Effects
    class MissileKineticDmgBonus2 < Effect
      description 'Skill: rockets, light missiles, heavy missiles etc'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        MissileDamageBonus.new(
          damage_type: :kinetic,
          skill: mod,
          skill_lvl: skill_lvl,
          fitting: fitting
        ).apply
      end
    end
  end
end
