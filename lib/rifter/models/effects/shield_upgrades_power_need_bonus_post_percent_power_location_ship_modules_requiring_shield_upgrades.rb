module Rifter
module Effects
  class ShieldUpgradesPowerNeedBonusPostPercentPowerLocationShipModulesRequiringShieldUpgrades < Effect

    def skill_effect(attrs, fitting:, skill_lvl:)
      # power_need_bonus: -5.0
      fitting.fitted_modules(klass: ShipModules::ShieldExtender).each do |m|
        m.power_usage *= (100.0 + miscellaneous_attributes.power_need_bonus * skill_lvl) / 100.0
      end
    end

  end
end

end