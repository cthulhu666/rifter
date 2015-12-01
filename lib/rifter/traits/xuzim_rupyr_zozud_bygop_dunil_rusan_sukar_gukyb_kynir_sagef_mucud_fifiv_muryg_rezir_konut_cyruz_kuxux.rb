module Rifter
  module Traits
    class XuzimRupyrZozudBygopDunilRusanSukarGukybKynirSagefMucudFifivMurygRezirKonutCyruzKuxux < Trait
      # used in 13 ships
      description 'bonus to <a href=showinfo:3307>Large Hybrid Turret</a> tracking speed'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Hybrid Turret') },
          :tracking_speed,
          bonus * skill_lvl
        )
      end
    end
  end
end
