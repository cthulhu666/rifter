module Rifter
  module Traits
    class XigakBeryzBunycTyvetDumyfFupotBagydCakuzVuratHakosKynalVymicFicizSocynFezefKucukGaxyx < Trait
      # used in 3 ships
      description 'bonus to missile damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.is_launcher? },
          :alpha_dmg,
          bonus * skill_lvl
        )
      end
    end
  end
end
