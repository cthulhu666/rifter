module Rifter
  module Traits
    class XucipZacyvManapRenozMonuvPemypVagukSocupLubasHytulKamozGirohPulovDanasRuhuzVefyfGixix < Trait
      LAUNCHERS = [ShipModules::MissileLauncherLight, ShipModules::MissileLauncherRocket]

      # used in 2 ships
      description 'bonus to <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.fitted_modules(klass: LAUNCHERS).each do |l|
          l.alpha_dmg *= 1.0 + (bonus * skill_lvl / 100.0)
        end
      end
    end
  end
end
