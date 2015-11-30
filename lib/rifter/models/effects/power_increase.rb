module Rifter
module Effects
  class PowerIncrease < Effect

    description "Auxiliary Power Core"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
                 :power_output,
                 miscellaneous_attributes.power_increase,
                 type: :flat
      )
    end

  end
end

end