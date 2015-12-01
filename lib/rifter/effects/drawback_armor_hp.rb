module Rifter
  module Effects
    class DrawbackArmorHP < Effect
      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :armor_capacity,
          fitted_module.drawback,
          stacking_penalty: true
        )
      end
    end
  end
end
