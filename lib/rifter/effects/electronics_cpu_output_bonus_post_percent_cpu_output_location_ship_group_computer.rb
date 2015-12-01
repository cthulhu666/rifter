module Rifter
module Effects
  class ElectronicsCpuOutputBonusPostPercentCpuOutputLocationShipGroupComputer < Effect

    def skill_effect(attrs, fitting:, skill_lvl:)
      #attrs.cpu_output *= 1 + miscellaneous_attributes.cpu_output_bonus2 * skill_lvl / 100.0
      fitting.boost_attribute(
                 :cpu_output,
                 miscellaneous_attributes.cpu_output_bonus2 * skill_lvl
      )
    end

    def effect(attrs, fitting:, fitted_module:)
      #attrs.cpu_output *= 1 + miscellaneous_attributes.cpu_output_bonus2 / 100
      fitting.boost_attribute(
          :cpu_output,
          miscellaneous_attributes.cpu_output_bonus2
      )
    end

  end
end

end