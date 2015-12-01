module Rifter
module Traits
  class XumonNovanKicehCacenDenosHobitBimynZyficNagesTemytBacisMotyhLycucFubidZotazCirohGexux < Trait

    LAUNCHER_CLASSES = [ShipModules::MissileLauncherHeavy, ShipModules::MissileLauncherHeavyAssault]

    # used in 3 ships
    description "bonus to kinetic <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> damage"

    def effect(fitting:, skill_lvl:)
      multiplier = bonus * skill_lvl / 100.0
      fitting.fitted_modules(klass: LAUNCHER_CLASSES).each do |l|
        l.alpha_dmg *= {kinetic: 1.0 + multiplier}
      end

    end
  end
end

end