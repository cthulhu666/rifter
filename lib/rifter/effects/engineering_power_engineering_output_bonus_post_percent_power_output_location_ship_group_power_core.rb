module Rifter
module Effects
  class EngineeringPowerEngineeringOutputBonusPostPercentPowerOutputLocationShipGroupPowerCore < Effect

    def effect(attrs, fitting:, fitted_module:)
      #attrs.power_output *= 1 + miscellaneous_attributes.power_engineering_output_bonus / 100
      fitting.boost_attribute(
                 :power_output,
                 miscellaneous_attributes.power_engineering_output_bonus
      )
    end

  end
end

end