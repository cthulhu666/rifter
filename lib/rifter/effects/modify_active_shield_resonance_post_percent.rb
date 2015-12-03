module Rifter
  module Effects
    class ModifyActiveShieldResonancePostPercent < Effect
      description "Used by 'Shield Hardener' modules"

      def effect(_attrs, fitting:, fitted_module:)
        ShipModule::DAMAGE_TYPES.each do |dmg_type|
          fitting.boost_attribute(
            :shield_resonances,
            fitted_module.resistance_bonus[dmg_type],
            nested_property: dmg_type,
            stacking_penalty: true
          )
        end
      end
    end
  end
end
