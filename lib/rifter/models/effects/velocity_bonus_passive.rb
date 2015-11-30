module Rifter
module Effects
  class VelocityBonusPassive < Effect

    description "Rigs: Polycarbon Engine Housing"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :max_velocity,
          miscellaneous_attributes.implant_bonus_velocity,
          stacking_penalty: true,
      )
    end

  end
end

end