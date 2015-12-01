module Rifter
module Effects
  class DrawbackPowerNeedProjectiles < Effect

    description "Rig Projectile Weapon"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.group == 'Projectile Weapon' },
        :power_usage,
        fitted_module.drawback
      )
    end

  end
end

end