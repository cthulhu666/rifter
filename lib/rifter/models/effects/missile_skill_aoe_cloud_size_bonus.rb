module Rifter
module Effects
  class MissileSkillAoeCloudSizeBonus < Effect

    description "Warhead Rigor Catalyst rig; Guided Missile Precision skill"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :aoe_cloud_size,
        miscellaneous_attributes.aoe_cloud_size_bonus,
        stacking_penalty: true
      )
    end

    # TODO skill_effect
  end
end

end