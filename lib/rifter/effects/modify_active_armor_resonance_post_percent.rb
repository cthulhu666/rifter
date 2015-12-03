module Rifter
  module Effects
    class ModifyActiveArmorResonancePostPercent < Effect
      description "Used by 'Armor Hardener' modules"

      def effect(_attrs, fitting:, fitted_module:)
        ShipModule::DAMAGE_TYPES.each do |dmg_type|
          fitting.boost_attribute(
            :armor_resonances,
            fitted_module.resistance_bonus[dmg_type],
            nested_property: dmg_type,
            stacking_penalty: true
          )
        end
      end
    end
  end
end
