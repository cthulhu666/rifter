module Rifter
  module Traits
    class XizakFonabMytahGecekCogopHekuhPimuvMynybLisydHozafSekinSaracNofekGapuhRivurRegykZaxix < Trait
      description 'bonus to EM, explosive, thermal <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> damage'

      GROUPS = ['Missile Launcher Rocket', 'Missile Launcher Light']

      def effect(fitting:, skill_lvl:)
        multiplier = 1.0 + bonus * skill_lvl / 100.0
        fitting.boost_module_attribute(
          -> (m) { m.item.group.in?(GROUPS) },
          :alpha_dmg,
          { em: multiplier, thermal: multiplier, explosive: multiplier },
          type: :multiplier
        )
      end
    end
  end
end
