module Rifter
module Effects
  class GunneryFalloffBonusOnline < Effect

    description "Tracking Enhancer"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Gunnery') },
        :falloff,
        miscellaneous_attributes.falloff_bonus,
        stacking_penalty: true
      )
    end

  end
end

end