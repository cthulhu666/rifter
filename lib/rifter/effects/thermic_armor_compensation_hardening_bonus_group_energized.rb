module Rifter
  module Effects
    class ThermicArmorCompensationHardeningBonusGroupEnergized < Effect
      description 'Thermal Armor Compensation skill'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.is_a?(ShipModules::ArmorPlatingEnergized) },
          :resistance_bonus,
          miscellaneous_attributes.hardening_bonus * skill_lvl,
          nested_property: :thermal
        )
      end
    end
  end
end
