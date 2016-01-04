module Rifter
  module Effects
    class ModifyPowerRechargeRate < Effect
      description 'Capacitor Flux Coil, Capacitor Power Relay, Capacitor Recharger, Power Diagnostic System, Reactor Control Unit, Shield Power Relay'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :recharge_rate,
          miscellaneous_attributes.capacitor_recharge_rate_multiplier,
          type: :multiplier
        )
      end
    end
  end
end
