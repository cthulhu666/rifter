module Rifter
  module Traits
    class XurovKalekGugupZytinCenykFutilBynufCykonDimimNupirPurucFagibVonukZifipZesubPafufZoxox < Trait
      # used in 4 ships
      description 'bonus to <a href=showinfo:3306>Medium Energy Turret</a> optimal range'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Medium Energy Turret') },
          :optimal,
          bonus * skill_lvl
        )
      end
    end
  end
end
