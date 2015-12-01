module Rifter
module Effects
  class SpeedBoostMassSigRad < Effect

    description "Microwarpdrives"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :mass,
          fitted_module.mass_addition,
          type: :flat
      )
      fitting.boost_attribute(
                 :signature_radius,
                 fitted_module.signature_radius_bonus,
                 stacking_penalty: true
      )
    end
  end
end

end