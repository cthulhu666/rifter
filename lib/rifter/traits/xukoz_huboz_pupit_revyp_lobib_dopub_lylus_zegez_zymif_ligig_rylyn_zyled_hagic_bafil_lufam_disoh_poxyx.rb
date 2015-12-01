module Rifter
  module Traits
    class XukozHubozPupitRevypLobibDopubLylusZegezZymifLigigRylynZyledHagicBafilLufamDisohPoxyx < Trait
      # TODO: generated class
      # used in 8 ships
      description 'bonus to <a href=showinfo:3305>Medium Projectile Turret</a> falloff'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Medium Projectile Turret') },
          :falloff,
          bonus * skill_lvl
        )
      end
    end
  end
end
