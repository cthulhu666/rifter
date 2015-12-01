module Rifter
  module Traits
    class XitizMifezTasinRifimRecegHogylSymemVevivFicabGefunZylimTytepHihicBogupHaribMozosRixex < Trait
      LAUNCHERS = [ShipModules::MissileLauncherRapidHeavy, ShipModules::MissileLauncherCruise, ShipModules::MissileLauncherTorpedo]

      # used in 9 ships
      description 'bonus to Rapid <a href=showinfo:3324>Heavy Missile</a>, <a href=showinfo:3326>Cruise Missile</a> and <a href=showinfo:3325>Torpedo</a> Launcher rate of fire'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.class.in?(LAUNCHERS) },
          :speed,
          -bonus * skill_lvl
        )
      end
    end
  end
end
