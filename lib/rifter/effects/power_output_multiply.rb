module Rifter
  module Effects
    class PowerOutputMultiply < Effect
      description 'Power Diagnostic System'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :power_output,
          miscellaneous_attributes.power_output_multiplier,
          type: :multiplier
        ) if miscellaneous_attributes.respond_to?(:power_output_multiplier)
      end
    end
  end
end
