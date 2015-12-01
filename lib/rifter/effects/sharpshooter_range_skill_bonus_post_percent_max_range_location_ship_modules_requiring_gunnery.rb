module Rifter
  module Effects
    class SharpshooterRangeSkillBonusPostPercentMaxRangeLocationShipModulesRequiringGunnery < Effect
      description 'Sharpshooter skill'

      def skill_effect(_attributes, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Gunnery') },
          :optimal,
          miscellaneous_attributes.range_skill_bonus * skill_lvl
        )
      end
    end
  end
end
