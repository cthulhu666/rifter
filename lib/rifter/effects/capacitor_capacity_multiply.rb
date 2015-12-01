module Rifter
module Effects
  class CapacitorCapacityMultiply < Effect

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :capacitor_capacity,
          miscellaneous_attributes.capacitor_capacity_multiplier,
          type: :multiplier
      )
    end
  end
end

end