module Rifter
  module Effects
    class EnergysystemsoperationCapRechargeBonusPostPercentRechargeRateLocationShipGroupCapacitor < Effect
      def effect(_attributes, fitting:, fitted_module:)
        fitting.boost_attribute(:recharge_rate, miscellaneous_attributes.cap_recharge_bonus, type: :percent)
      end

      def skill_effect(_attributes, fitting:, skill_lvl:)
        fitting.boost_attribute(:recharge_rate, miscellaneous_attributes.cap_recharge_bonus * skill_lvl, type: :percent)
      end
    end
  end
end
