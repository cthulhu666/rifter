module Rifter
module Traits
  class XisogMonovNynudMucutKykugFagutRofebCosagHofusRunukSepacFicekVepimBorerZycilZevymDaxex < Trait

    LAUNCHERS = [ShipModules::MissileLauncherHeavy, ShipModules::MissileLauncherHeavyAssault, ShipModules::MissileLauncherLight, ShipModules::MissileLauncherRapidLight]

    # used in 4 ships
    description "bonus to kinetic <a href=showinfo:3321>Light Missile</a>, <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> damage"

    # TODO: refactor
    def effect(fitting:, skill_lvl:)
      multiplier = bonus * skill_lvl / 100.0
      fitting.launchers.select { |l| l.item.class.in?(LAUNCHERS)}.each do |l|
        l.alpha_dmg *= {kinetic: 1.0 + multiplier, thermal: 1.0 + multiplier}
      end
    end
  end
end

end