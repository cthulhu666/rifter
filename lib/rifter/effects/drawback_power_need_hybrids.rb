module Rifter
module Effects
  class DrawbackPowerNeedHybrids < Effect

    description "Rig Hybrid Weapon"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.group == 'Hybrid Weapon' },
        :power_usage,
        fitted_module.drawback
      )
    end

  end
end

end