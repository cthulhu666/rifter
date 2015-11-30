module Rifter
module Effects
  class MissileLauncherSpeedMultiplierPassive < Effect

    description "Bay Loading Accelerator rig"

    def effect(attrs, fitting:, fitted_module:)
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