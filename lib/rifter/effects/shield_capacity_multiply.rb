module Rifter
module Effects
  class ShieldCapacityMultiply < Effect

    description "Used by Shield Power Relay, Power Diagnostic System, Capacitor Power Relay, Capacitor Flux Coil, Reactor Control Unit, Shield Flux Coil"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :shield_capacity,
          miscellaneous_attributes.shield_capacity_multiplier,
          type: :multiplier
      )
    end

  end
end

end