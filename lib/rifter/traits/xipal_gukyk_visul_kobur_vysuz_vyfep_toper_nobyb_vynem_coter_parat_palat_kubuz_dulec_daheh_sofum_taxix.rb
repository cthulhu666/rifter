module Rifter
  module Traits
    class XipalGukykVisulKoburVysuzVyfepToperNobybVynemCoterParatPalatKubuzDulecDahehSofumTaxix < Trait
      # used in 8 ships
      description 'bonus to kinetic <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> damage'

      GROUPS = ['Missile Launcher Rocket', 'Missile Launcher Light']

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group.in?(GROUPS) },
          :alpha_dmg,
          { kinetic: 1.0 + bonus * skill_lvl / 100.0 },
          type: :multiplier
        )
      end
    end
  end
end
