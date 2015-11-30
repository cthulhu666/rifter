module Rifter
module Effects
  class EngineeringSkillBoostPowerOutputBonus < Effect

    def skill_effect(attrs, fitting:, skill_lvl:)
      # attrs.power_output *= 1 + miscellaneous_attributes.power_engineering_output_bonus * skill_lvl / 100.0
      fitting.boost_attribute(
                 :power_output,
                 miscellaneous_attributes.power_engineering_output_bonus * skill_lvl
      )
    end

  end
end

end