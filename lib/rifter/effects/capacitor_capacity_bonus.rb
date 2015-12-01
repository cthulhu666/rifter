module Rifter
  module Effects
    class CapacitorCapacityBonus < Effect
      def effect(_attributes, fitting:, fitted_module:)
        fitting.boost_attribute(:capacitor_capacity, miscellaneous_attributes.capacitor_bonus, type: :flat)
      end
    end
  end
end
