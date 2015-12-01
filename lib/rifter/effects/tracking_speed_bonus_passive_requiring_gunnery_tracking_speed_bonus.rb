module Rifter
  module Effects
    class TrackingSpeedBonusPassiveRequiringGunneryTrackingSpeedBonus < Effect
      description 'Motion Prediction skill'

      def skill_effect(_attributes, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Gunnery') },
          :tracking_speed,
          miscellaneous_attributes.tracking_speed_bonus * skill_lvl
        )
      end
    end
  end
end
