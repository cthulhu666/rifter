module Rifter
  module Effects
    class ShieldCapacityMultiply < Effect
      description 'Used by Shield Power Relay, Power Diagnostic System, Capacitor Power Relay, Capacitor Flux Coil, Reactor Control Unit, Shield Flux Coil'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :shield_capacity,
          miscellaneous_attributes.shield_capacity_multiplier,
          type: :multiplier
        ) if miscellaneous_attributes.respond_to?(:shield_capacity_multiplier)
      end
    end
  end
end
