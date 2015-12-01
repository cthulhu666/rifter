module Rifter
  module Effects
    class SelfT2LargeHybridBlasterDamageBonus < Effect
      description 'Large Blaster Specialization skill'

      def skill_effect(_attributes, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Blaster Specialization') },
          :damage_multiplier,
          miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
        )
      end
    end
  end
end
