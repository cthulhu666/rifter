module Rifter
module Effects
  class RigDrawbackBonusEffect < Effect

    MAPPING = {
        'Armor Rigging' => [ShipModules::RigArmor],
        'Astronautics Rigging' => [ShipModules::RigNavigation],
        'Drones Rigging' => [ShipModules::RigDrones],
        'Electronic Superiority Rigging' => [
            ShipModules::RigElectronicSystems,
            ShipModules::RigScanning,
            ShipModules::RigTargeting,
            ShipModules::RigResourceProcessing
        ],
        'Projectile Weapon Rigging' => [ShipModules::RigProjectileWeapon],
        'Energy Weapon Rigging' => [ShipModules::RigEnergyWeapon],
        'Hybrid Weapon Rigging' => [ShipModules::RigHybridWeapon],
        'Launcher Rigging' => [ShipModules::RigLauncher],
        'Shield Rigging' => [ShipModules::RigShield],
    }

    def skill_effect(attrs, fitting:, skill_lvl:)
      klass.each do |k|
        fitting.fitted_modules(klass: k).select { |r| r.respond_to?(:drawback) }.each do |r|
          r.drawback *= (100.0 + miscellaneous_attributes.rig_drawback_bonus * skill_lvl) / 100.0
        end
      end
    end

    def klass
      # ShipFitting#fitted_modules(klass: nil) returns all fitted modules,
      # so we pass some Class to force it to return nil
      MAPPING[mod.name] || self.class
    end

  end
end

end