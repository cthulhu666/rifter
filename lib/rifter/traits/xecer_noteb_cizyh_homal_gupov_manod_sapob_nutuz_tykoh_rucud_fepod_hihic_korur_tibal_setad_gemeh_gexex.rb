module Rifter
  module Traits
    class XecerNotebCizyhHomalGupovManodSapobNutuzTykohRucudFepodHihicKorurTibalSetadGemehGexex < Trait
      # used in 21 ships

      description 'bonus to <a href=showinfo:3304>Medium Hybrid Turret</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Medium Hybrid Turret') },
          :damage_multiplier,
          bonus * skill_lvl
        )
      end
    end
  end
end
