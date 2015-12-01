module Rifter
  module Effects
    class DrawbackRepairSystemsPGNeed < Effect
      description 'Auxiliary Nano Pump, Nanobot Accelerator rigs'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Repair Systems') },
          :power_usage,
          fitted_module.drawback
        )
      end
    end
  end
end
