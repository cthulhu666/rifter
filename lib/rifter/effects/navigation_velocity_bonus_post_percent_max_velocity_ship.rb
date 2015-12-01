module Rifter
  module Effects
    class NavigationVelocityBonusPostPercentMaxVelocityShip < Effect
      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_attribute(:max_velocity, miscellaneous_attributes.velocity_bonus * skill_lvl)
      end
    end
  end
end
