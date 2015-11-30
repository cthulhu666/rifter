module Rifter
module Effects
  class AccerationControlSkillAbAndMwdSpeedBoost < Effect

    description "Acceleration Control skill"

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_module_attribute(
          -> (m) { m.item.group == "Propulsion Module" },
          :speed_factor,
          miscellaneous_attributes.speed_f_bonus * skill_lvl
      )
    end

  end
end

end