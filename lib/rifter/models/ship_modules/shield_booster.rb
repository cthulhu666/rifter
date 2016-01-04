module Rifter
  module ShipModules
    class ShieldBooster < ShipModule
      copy_attributes :capacitor_need, :duration

      def setup(fitted_module)
        super
        class << fitted_module
          include FittedModuleInstanceMethods
        end
      end

      module FittedModuleInstanceMethods
        def cap_usage
          capacitor_need / duration * 1000.0
        end
      end
    end
  end
end
