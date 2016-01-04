module Rifter
  module Effects
    class ArmorRepair < Effect
      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :shield_boost,
          miscellaneous_attributes.shield_bonus / miscellaneous_attributes.duration * 1000.0,
          type: :flat
        )
      end
    end
  end
end
