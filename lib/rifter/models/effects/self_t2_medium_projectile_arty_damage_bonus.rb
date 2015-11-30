module Rifter
module Effects
  class SelfT2MediumProjectileArtyDamageBonus < Effect

    description "Medium Artillery Specialization skill"

    def skill_effect(attributes, fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Medium Artillery Specialization') },
        :damage_multiplier,
        miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
      )

    end
  end
end

end