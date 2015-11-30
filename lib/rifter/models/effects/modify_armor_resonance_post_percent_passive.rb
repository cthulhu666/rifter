module Rifter
module Effects
  class ModifyArmorResonancePostPercentPassive < Effect

    def post_effect(attrs, opts = {})
      # TODO stacking penalties
      ShipModule::DAMAGE_TYPES.each do |dmg_type|
        if bonus = miscellaneous_attributes["#{dmg_type}_damage_resistance_bonus"]
          bonus = bonus.abs / 100
          attrs.armor_resonances[dmg_type] -= attrs.armor_resonances[dmg_type] * bonus
        end
      end
    end

  end
end

end