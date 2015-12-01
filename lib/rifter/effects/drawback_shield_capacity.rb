module Rifter
  module Effects
    class DrawbackShieldCapacity < Effect
      description 'Rig Electronic Systems, Rig Targeting rigs'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :shield_capacity,
          fitted_module.drawback,
          stacking_penalty: true
        )
      end
    end
  end
end
