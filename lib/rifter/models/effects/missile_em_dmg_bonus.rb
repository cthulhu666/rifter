module Rifter
module Effects
  class MissileEMDmgBonus < Effect

    description "Skill: rockets, light missiles, heavy missiles etc"

    def skill_effect(attrs, fitting:, skill_lvl:)
      MissileDamageBonus.new(
          damage_type: :em,
          skill: mod,
          skill_lvl: skill_lvl,
          fitting: fitting
      ).apply
    end

  end
end

end