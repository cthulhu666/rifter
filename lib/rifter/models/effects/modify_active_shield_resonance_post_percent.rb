module Rifter
module Effects
  class ModifyActiveShieldResonancePostPercent < Effect

    description "Used by 'Shield Hardener' modules"

    def effect(attrs, fitting:, fitted_module:)
      ShipModule::DAMAGE_TYPES.each do |dmg_type|
        bonus = fitted_module.resistance_bonus[dmg_type].abs / 100.0
        stacking_penalty(bonus, attrs, "#{self.class}:#{dmg_type}") do |value|
          attrs.shield_resonances[dmg_type] -= attrs.shield_resonances[dmg_type] * value
        end
      end
    end

  end
end

end