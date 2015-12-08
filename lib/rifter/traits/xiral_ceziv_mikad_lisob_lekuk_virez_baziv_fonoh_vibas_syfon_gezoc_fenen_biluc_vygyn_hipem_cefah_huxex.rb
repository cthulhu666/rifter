module Rifter
  module Traits
    class XiralCezivMikadLisobLekukVirezBazivFonohVibasSyfonGezocFenenBilucVygynHipemCefahHuxex < Trait
      description 'bonus to EM, kinetic, thermal <a href=showinfo:3320>Rocket</a> damage'

      def effect(fitting:, skill_lvl:)
        multiplier = 1.0 + bonus * skill_lvl / 100.0
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Missile Launcher Rocket' },
          :alpha_dmg,
          { em: multiplier, thermal: multiplier, kinetic: multiplier },
          type: :multiplier
        )
      end
    end
  end
end
