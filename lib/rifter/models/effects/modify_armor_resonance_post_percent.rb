module Rifter
module Effects
  class ModifyArmorResonancePostPercent < Effect

    description "Used by 'Armor Plating Energized' modules"

    def effect(attrs, fitting:, fitted_module:)
      Damage::DAMAGE_TYPES.each do |d|
        fitting.boost_attribute(
            :armor_resonances,
            -> { fitted_module.resistance_bonus[d] },
            nested_property: d,
            stacking_penalty: true
        )
      end
    end

  end
end

end