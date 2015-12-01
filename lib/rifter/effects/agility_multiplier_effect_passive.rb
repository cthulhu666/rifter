module Rifter
  module Effects
    class AgilityMultiplierEffectPassive < Effect
      description 'Polycarbon Engine Housing'

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
