module Rifter
  module Effects
    class ModifyShieldRechargeRate < Effect
      description 'Shield Flux Coil'

      def effect(_attrs, fitting:, fitted_module:)
        # e.g. 'Beta Reactor Control: Capacitor Power Relay I' uses this effect, but doesn't modify shield recharge rate
        if multiplier = miscellaneous_attributes.try(:shield_recharge_rate_multiplier)
          fitting.boost_attribute(:shield_recharge_rate, multiplier, type: :multiplier)
        end
      end
    end
  end
end
