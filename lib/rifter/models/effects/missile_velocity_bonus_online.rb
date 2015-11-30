module Rifter
module Effects
  class MissileVelocityBonusOnline < Effect

    description "Missile Guidance Enhancer"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :max_velocity,
        miscellaneous_attributes.missile_velocity_bonus,
        stacking_penalty: true
      )
    end

  end
end

end