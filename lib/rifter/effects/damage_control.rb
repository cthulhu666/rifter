module Rifter
module Effects
  class DamageControl < Effect

    def effect(attrs, fitting: nil, fitted_module: nil)
      ShipModule::DAMAGE_TYPES.each do |dmg_type|
        attrs.shield_resonances[dmg_type] *= miscellaneous_attributes["shield_#{dmg_type}_damage_resonance"]
        attrs.armor_resonances[dmg_type] *= miscellaneous_attributes["armor_#{dmg_type}_damage_resonance"]
        attrs.hull_resonances[dmg_type] *= miscellaneous_attributes["hull_#{dmg_type}_damage_resonance"]
      end
    end

  end
end

end