module Rifter
  module Effects
    class DrawbackMaxVelocity < Effect
      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :max_velocity,
          fitted_module.drawback,
          stacking_penalty: true
        )
      end
    end
  end
end
