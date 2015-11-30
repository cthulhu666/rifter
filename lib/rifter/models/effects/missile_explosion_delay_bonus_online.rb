module Rifter
module Effects
  class MissileExplosionDelayBonusOnline < Effect

    description "Missile Guidance Enhancer"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :explosion_delay,
        miscellaneous_attributes.explosion_delay_bonus,
        stacking_penalty: true
      )
    end

  end
end

end