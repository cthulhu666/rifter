module Rifter
  module Effects
    class ShieldBoosting < Effect
      def effect(_attrs, fitting:, fitted_module:)
        # attrs.shield_boost += miscellaneous_attributes.shield_bonus / miscellaneous_attributes.duration * 1000.0
        fail NotImplementedError
      end
    end
  end
end
