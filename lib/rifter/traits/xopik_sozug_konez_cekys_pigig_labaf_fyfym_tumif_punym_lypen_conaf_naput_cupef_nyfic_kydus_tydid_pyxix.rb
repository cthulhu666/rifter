module Rifter
  module Traits
    class XopikSozugKonezCekysPigigLabafFyfymTumifPunymLypenConafNaputCupefNyficKydusTydidPyxix < Trait
      # used in 19 ships
      description 'bonus to <a href=showinfo:3301>Small Hybrid Turret</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Small Hybrid Turret') },
          :damage_multiplier,
          bonus * skill_lvl
        )
      end
    end
  end
end
