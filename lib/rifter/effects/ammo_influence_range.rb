module Rifter
  module Effects
    class AmmoInfluenceRange < Effect
      description 'Various sort of Ammo'

      def effect(_attrs, fitting:, fitted_module:)
        fitted_module.boost_attribute(
          :optimal,
          miscellaneous_attributes.weapon_range_multiplier,
          type: :multiplier
        )
      end
    end
  end
end
