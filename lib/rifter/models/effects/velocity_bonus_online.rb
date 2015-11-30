module Rifter
module Effects
  class VelocityBonusOnline < Effect

    description "Nanofiber Internal Structure, Overdrive Injector System"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :max_velocity,
          miscellaneous_attributes.implant_bonus_velocity,
          stacking_penalty: true
      )
    end

  end
end

end