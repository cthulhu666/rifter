module Rifter
  module Effects
    class AgilityMultiplierEffect < Effect
      description 'Nanofiber Internal Structure, Inertial Stabilizer, Reinforced Bulkhead'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :agility,
          miscellaneous_attributes.agility_multiplier,
          stacking_penalty: true
        )
      end
    end
  end
end
