module Rifter
module Effects
  class SelfT2LargeProjectileArtyDamageBonus < Effect
    description "Large Artillery Specialization skill"

    def skill_effect(attributes, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Large Artillery Specialization') },
        :damage_multiplier,
        miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
      )

    end
  end
end

end