module Rifter
module Effects
  class SurgicalStrikeFalloffBonusPostPercentFalloffLocationShipModulesRequiringGunnery < Effect

    description 'Trajectory Analysis skill'

    def skill_effect(attributes, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Gunnery') },
        :falloff,
        miscellaneous_attributes.falloff_bonus * skill_lvl
      )

    end

  end
end

end