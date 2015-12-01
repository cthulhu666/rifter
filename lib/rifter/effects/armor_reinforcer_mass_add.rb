module Rifter
  module Effects
    class ArmorReinforcerMassAdd < Effect
      description "Used by 'Armor Reinforcer' modules"

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(:mass, miscellaneous_attributes.mass_addition, type: :flat)
      end
    end
  end
end
