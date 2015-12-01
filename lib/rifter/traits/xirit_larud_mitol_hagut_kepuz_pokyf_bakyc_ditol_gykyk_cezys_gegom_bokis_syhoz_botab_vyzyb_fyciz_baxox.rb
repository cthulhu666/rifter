module Rifter
  module Traits
    class XiritLarudMitolHagutKepuzPokyfBakycDitolGykykCezysGegomBokisSyhozBotabVyzybFycizBaxox < Trait
      # used in 22 ships
      description 'bonus to <a href=showinfo:3416>Shield Booster</a> amount'

      def effect(fitting:, skill_lvl:)
        fitting.boost_attribute(
          :shield_boost,
          bonus * skill_lvl
        )
      end
    end
  end
end
