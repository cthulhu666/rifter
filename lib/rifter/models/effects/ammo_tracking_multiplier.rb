module Rifter
module Effects
  class AmmoTrackingMultiplier < Effect

    description "Various sort of Ammo"

    def effect(attrs, fitting:, fitted_module:)
      fitted_module.boost_attribute(
          :tracking_speed,
          miscellaneous_attributes.tracking_speed_multiplier,
          type: :multiplier
      )
    end

  end
end

end