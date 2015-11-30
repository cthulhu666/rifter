module Rifter
module Traits
  class XipalGukykVisulKoburVysuzVyfepToperNobybVynemCoterParatPalatKubuzDulecDahehSofumTaxix < Trait

    # used in 8 ships
    description "bonus to kinetic <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> damage"

    LAUNCHER_CLASSES = [ShipModules::MissileLauncherRocket, ShipModules::MissileLauncherLight]

    def effect(fitting:, skill_lvl:)
      multiplier = bonus * skill_lvl / 100.0
      fitting.fitted_modules(klass: LAUNCHER_CLASSES).each do |l|
        l.alpha_dmg *= {kinetic: 1.0 + multiplier}
      end

    end

  end
end

end