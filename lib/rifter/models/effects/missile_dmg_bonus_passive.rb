module Rifter
module Effects
  class MissileDMGBonusPassive < Effect

    def effect(attrs, fitting:, fitted_module:)
      # missile_damage_multiplier_bonus: 1.15
      fitting.launchers.each do |l|
        bonus = l.alpha_dmg * (miscellaneous_attributes.missile_damage_multiplier_bonus - 1.0)
        stacking_penalty(bonus, attrs, "#{self.class}:#{l.id}") do |value|
          l.alpha_dmg += value
        end
      end
    end
  end
end

end