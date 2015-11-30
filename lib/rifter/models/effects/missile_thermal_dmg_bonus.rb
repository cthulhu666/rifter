module Rifter
module Effects
  class MissileThermalDmgBonus < Effect

    description "Skill: rockets, light missiles, heavy missiles etc"

    def skill_effect(attrs, fitting:, skill_lvl:)
      MissileDamageBonus.new(
          damage_type: :thermal,
          skill: mod,
          skill_lvl: skill_lvl,
          fitting: fitting
      ).apply
    end

  end
end

end