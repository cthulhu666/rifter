module Rifter
  module Effects
    class MissileLauncherSpeedMultiplier < Effect
      description 'Ballistic Control System modules'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :speed,
          miscellaneous_attributes.speed_multiplier,
          type: :multiplier,
          stacking_penalty: true
        )
      end
    end
  end
end
