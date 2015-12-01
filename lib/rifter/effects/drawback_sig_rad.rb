module Rifter
  module Effects
    class DrawbackSigRad < Effect
      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :signature_radius,
          fitted_module.drawback,
          stacking_penalty: true
        )
      end
    end
  end
end
