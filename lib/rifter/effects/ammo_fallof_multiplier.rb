module Rifter
  module Effects
    class AmmoFallofMultiplier < Effect
      description 'Advanced Ammo'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.boost_attribute(
          :falloff,
          miscellaneous_attributes.fallof_multiplier,
          type: :multiplier
        ) if miscellaneous_attributes[:fallof_multiplier]
      end
    end
  end
end
