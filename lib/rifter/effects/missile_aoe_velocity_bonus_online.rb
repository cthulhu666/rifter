module Rifter
  module Effects
    class MissileAOEVelocityBonusOnline < Effect
      description 'Missile Guidance Enhancer'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :aoe_velocity,
          miscellaneous_attributes.aoe_velocity_bonus,
          stacking_penalty: true
        )
      end
    end
  end
end
