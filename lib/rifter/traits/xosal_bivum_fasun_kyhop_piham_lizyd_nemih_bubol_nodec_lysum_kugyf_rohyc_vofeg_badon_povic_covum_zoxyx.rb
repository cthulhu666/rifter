module Rifter
  module Traits
    class XosalBivumFasunKyhopPihamLizydNemihBubolNodecLysumKugyfRohycVofegBadonPovicCovumZoxyx < Trait
      # used in 12 ships
      description 'bonus to <a href=showinfo:3326>Cruise Missile</a> and <a href=showinfo:3325>Torpedo</a> max velocity'

      GROUP = ['Cruise Missile Launcher', 'Torpedo Launcher']

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group.in?(GROUP) },
          :max_velocity,
          skill_lvl * bonus
        )
      end
    end
  end
end
