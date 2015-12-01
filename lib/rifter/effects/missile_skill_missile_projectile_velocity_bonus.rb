module Rifter
  module Effects
    class MissileSkillMissileProjectileVelocityBonus < Effect
      description 'Hydraulic Bay Thrusters rigs, Missile Projection skill'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :max_velocity,
          miscellaneous_attributes.speed_factor,
          stacking_penalty: true
        )
      end

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :max_velocity,
          miscellaneous_attributes.speed_factor * skill_lvl
        )
      end
    end
  end
end
