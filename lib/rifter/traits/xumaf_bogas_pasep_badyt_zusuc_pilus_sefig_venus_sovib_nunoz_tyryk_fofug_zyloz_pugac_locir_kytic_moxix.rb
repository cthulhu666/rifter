module Rifter
  module Traits
    class XumafBogasPasepBadytZusucPilusSefigVenusSovibNunozTyrykFofugZylozPugacLocirKyticMoxix < Trait
      GROUPS = [
        'Missile Launcher Heavy', 'Missile Launcher Rapid Heavy',
        'Missile Launcher Cruise', 'Missile Launcher Torpedo'
      ]

      description 'bonus to <a href=showinfo:3324>Heavy Missile</a>, <a href=showinfo:3326>Cruise Missile</a> and <a href=showinfo:3325>Torpedo</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group.in?(GROUPS) },
          :alpha_dmg,
          bonus * skill_lvl
        )
      end
    end
  end
end
