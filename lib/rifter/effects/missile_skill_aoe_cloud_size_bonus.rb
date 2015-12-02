module Rifter
  module Effects
    class MissileSkillAoeCloudSizeBonus < Effect
      description 'Warhead Rigor Catalyst rig; Guided Missile Precision skill'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :aoe_cloud_size,
          miscellaneous_attributes.aoe_cloud_size_bonus,
          stacking_penalty: true
        )
      end

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :aoe_cloud_size,
          skill_lvl * miscellaneous_attributes.aoe_cloud_size_bonus
        )
      end
    end
  end
end
