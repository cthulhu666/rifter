module Rifter
  module Traits
    class XolizRacekHyhanMyhynMepibPilinRerupGopifDanacNazazVokavKymanGuzuhCezosVyrenDikunDyxex < Trait
      # used in 3 ships
      description 'bonus to missile velocity'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :max_velocity,
          bonus
        )
      end
    end
  end
end
