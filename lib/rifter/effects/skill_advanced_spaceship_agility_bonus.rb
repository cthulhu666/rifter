module Rifter
  module Effects
    class SkillAdvancedSpaceshipAgilityBonus < Effect
      description 'Skill: Advanced Spaceship Command'

      # TODO: only for ships that require that skill
      # + for some reason this method is not being called
      # def skill_effect(attrs, fitting:, skill_lvl:)
      #  fitting.boost_attribute(:agility, miscellaneous_attributes.agility_bonus * skill_lvl)
      # end
    end
  end
end
