module Rifter
  module Effects
    class MissileExplosiveDmgBonus < Effect
      description 'Skill: rockets, light missiles, heavy missiles etc'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        MissileDamageBonus.new(
          damage_type: :explosive,
          skill: mod,
          skill_lvl: skill_lvl,
          fitting: fitting
        ).apply
      end
    end
  end
end
