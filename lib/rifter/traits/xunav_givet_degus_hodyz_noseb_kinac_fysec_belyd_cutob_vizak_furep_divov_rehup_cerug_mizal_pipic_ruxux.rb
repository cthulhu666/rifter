module Rifter
  module Traits
    class XunavGivetDegusHodyzNosebKinacFysecBelydCutobVizakFurepDivovRehupCerugMizalPipicRuxux < Trait
      description 'bonus to explosive <a href=showinfo:3320>Rocket</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Missile Launcher Rocket' },
          :alpha_dmg,
          { explosive: 1.0 + bonus * skill_lvl / 100.0 },
          type: :multiplier
        )
      end
    end
  end
end
