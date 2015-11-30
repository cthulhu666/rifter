module Rifter
module Traits
  class XilesPenevLobugLarovLugelNekegPacodZegymGenilFomulNomukGizolRunefKavutRomabVefabCexox < Trait

    # used in 6 ships
    description "bonus to <a href=showinfo:3436>Drone</a> hitpoints, damage and mining yield"

    def effect(fitting:, skill_lvl:)
      fitting.drones.each do |drone|
        drone.boost_attribute(
            :damage_multiplier,
            bonus * skill_lvl
        )
      end
    end
    # TODO: hitpoints/mining yield
  end

end

end