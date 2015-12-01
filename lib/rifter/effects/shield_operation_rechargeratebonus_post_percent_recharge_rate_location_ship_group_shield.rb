module Rifter
module Effects
  class ShieldOperationRechargeratebonusPostPercentRechargeRateLocationShipGroupShield < Effect

    description "Core Defense Field Purger rigs, Shield Operation skill"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :shield_recharge_rate,
          miscellaneous_attributes.rechargeratebonus
      )
    end

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_attribute(
          :shield_recharge_rate,
          miscellaneous_attributes.rechargeratebonus * skill_lvl
      )
    end

  end
end

end