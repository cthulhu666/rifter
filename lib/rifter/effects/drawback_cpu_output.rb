module Rifter
  module Effects
    class DrawbackCPUOutput < Effect
      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :cpu_output,
          fitted_module.drawback,
          stacking_penalty: true
        )
      end
    end
  end
end
