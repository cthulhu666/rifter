module Rifter
module Effects
  class GunneryTurretSpeeBonusPostPercentSpeedLocationShipModulesRequiringGunnery < Effect

    description "Gunnery skill"

    def skill_effect(attrs, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Gunnery') },
        :speed,
        miscellaneous_attributes.turret_spee_bonus * skill_lvl
      )

    end

  end
end

end