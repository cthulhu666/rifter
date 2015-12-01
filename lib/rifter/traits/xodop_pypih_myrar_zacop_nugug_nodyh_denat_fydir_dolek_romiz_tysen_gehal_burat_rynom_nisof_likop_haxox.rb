module Rifter
  module Traits
    class XodopPypihMyrarZacopNugugNodyhDenatFydirDolekRomizTysenGehalBuratRynomNisofLikopHaxox < Trait
      # used in 20 ships
      description 'bonus to <a href=showinfo:3436>Drone</a> hitpoints and damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(Drone) },
          :damage_multiplier,
          bonus * skill_lvl
        )
        # TODO: hitpoints/mining yield
      end
    end
  end
end
