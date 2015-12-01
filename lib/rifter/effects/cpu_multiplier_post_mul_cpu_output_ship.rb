module Rifter
module Effects
  class CpuMultiplierPostMulCpuOutputShip < Effect

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
                 :cpu_output,
                 miscellaneous_attributes.cpu_multiplier,
                 type: :multiplier
      )
    end
  end
end

end