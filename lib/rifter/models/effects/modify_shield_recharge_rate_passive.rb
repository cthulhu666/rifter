module Rifter
module Effects
  class ModifyShieldRechargeRatePassive < Effect

    description "Processor Overclocking Unit"

    def effect(attrs, fitting:, fitted_module:)
      if multiplier = miscellaneous_attributes.try(:shield_recharge_rate_multiplier)
        fitting.boost_attribute(:shield_recharge_rate, multiplier, type: :multiplier)
      end
    end

  end
end

end