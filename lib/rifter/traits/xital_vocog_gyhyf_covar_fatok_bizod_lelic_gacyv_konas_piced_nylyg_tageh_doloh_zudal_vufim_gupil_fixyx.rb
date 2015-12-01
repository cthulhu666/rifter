module Rifter
  module Traits
    class XitalVocogGyhyfCovarFatokBizodLelicGacyvKonasPicedNylygTagehDolohZudalVufimGupilFixyx < Trait
      # used in 15 ships
      description 'bonus to <a href=showinfo:3309>Large Energy Turret</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Energy Turret') },
          :damage_multiplier,
          bonus * skill_lvl
        )
      end
    end
  end
end
