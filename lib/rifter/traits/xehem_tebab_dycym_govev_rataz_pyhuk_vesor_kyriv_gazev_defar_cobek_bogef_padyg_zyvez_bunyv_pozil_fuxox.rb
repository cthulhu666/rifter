module Rifter
  module Traits
    class XehemTebabDycymGovevRatazPyhukVesorKyrivGazevDefarCobekBogefPadygZyvezBunyvPozilFuxox < Trait
      # used in 6 ships
      description "bonus to <a href=showinfo:526>Stasis Webifier</a> optimal range"

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Stasis Web' },
          :max_range,
          bonus * skill_lvl,
        )
      end
    end
  end
end
