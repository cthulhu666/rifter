module Rifter
module Effects
  class MissileAOECloudSizeBonusOnline < Effect

    description "Missile Guidance Enhancer"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :aoe_cloud_size,
        miscellaneous_attributes.aoe_cloud_size_bonus,
        stacking_penalty: true
      )
    end

  end
end

end