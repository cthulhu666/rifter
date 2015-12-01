module Rifter
  module ShipModules
    class PowerDiagnosticSystem < ShipModule
      # TODO: move to effects !!

      def shield_capacity_multiplier
        miscellaneous_attributes.shield_capacity_multiplier
      end
    end
  end
end
