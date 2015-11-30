module Rifter
module Effects
  class MechanicHullHpBonusPostPercentHpShip < Effect

    description 'Skill: Mechanics'

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_attribute(
                 :hull_capacity,
                 miscellaneous_attributes.hull_hp_bonus * skill_lvl
      )
    end

  end
end

end