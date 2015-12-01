module Rifter
  module Traits
    class XuribHuzozBidogTomebCyzydSasuvLofolTelifGylutFevigHehyhDyhadZymutVuzatDucusFiligMixux < Trait
      # used in 1 ships
      description 'bonus to <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> explosion velocity'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { ['Rockets', 'Light Missiles'].any? { |s| m.item.skill_required?(s) } },
          :aoe_velocity,
          bonus * skill_lvl
        )
      end
    end
  end
end
