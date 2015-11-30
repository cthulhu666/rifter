module Rifter
module Effects
  class RapidFiringRofBonusPostPercentSpeedLocationShipModulesRequiringGunnery < Effect

    description "Rapid Firing Skill"

    def skill_effect(attrs, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Gunnery') },
        :speed,
        miscellaneous_attributes.rof_bonus * skill_lvl
      )

    end

  end
end

end