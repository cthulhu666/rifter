module Rifter
module Effects
  class PowerOutputMultiply < Effect

    description "Power Diagnostic System"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :power_output,
          miscellaneous_attributes.power_output_multiplier,
          type: :multiplier
      )
    end

  end
end

end