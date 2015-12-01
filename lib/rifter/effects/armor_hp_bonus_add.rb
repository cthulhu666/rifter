module Rifter
  module Effects
    class ArmorHPBonusAdd < Effect
      description "Used by 'Armor Reinforcer' modules"

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(:armor_capacity, miscellaneous_attributes.armor_hp_bonus_add, type: :flat)
      end
    end
  end
end
