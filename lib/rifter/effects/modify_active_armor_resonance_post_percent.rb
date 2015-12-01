module Rifter
  module Effects
    class ModifyActiveArmorResonancePostPercent < Effect
      description "Used by 'Armor Hardener' modules"

      def effect(attrs, fitting:, fitted_module:)
        # TODO: use ShipFitting#boost_attribute, but it doesn't handle hash attributes
        ShipModule::DAMAGE_TYPES.each do |dmg_type|
          bonus = fitted_module.resistance_bonus[dmg_type].abs / 100.0
          stacking_penalty(bonus, attrs, "#{self.class}:#{dmg_type}") do |value|
            attrs.armor_resonances[dmg_type] -= attrs.armor_resonances[dmg_type] * value
          end
        end
      end
    end
  end
end
