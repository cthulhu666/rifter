module Rifter
  module Effects
    class SelfT2SmallProjectileACDamageBonus < Effect
      description 'Small Autocannon Specialization skill'

      def skill_effect(_attributes, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Small Autocannon Specialization') },
          :damage_multiplier,
          miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
        )
      end
    end
  end
end
