module Rifter
  module Effects
    class ShieldOperationRechargeratebonusPostPercentOnline < Effect
      description 'Shield Power Relay'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(:shield_recharge_rate, miscellaneous_attributes.rechargeratebonus)
      end
    end
  end
end
