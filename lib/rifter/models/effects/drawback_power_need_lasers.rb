module Rifter
module Effects
  class DrawbackPowerNeedLasers < Effect

    description "Rig Energy Weapon"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.group == 'Energy Weapon' },
        :power_usage,
        fitted_module.drawback
      )
    end

  end
end

end