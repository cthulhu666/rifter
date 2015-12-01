module Rifter
  module Traits
    class XirinDygakGyhisPuzupGumymHehopDezuzKylepNybofBylegCesykFukuvZomukVomomGysefDivuhKixex < Trait
      # used in 6 ships
      description 'bonus to <a href=showinfo:3321>Light Missile</a>, <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> max velocity'

      GROUPS = ['Missile Launcher Light', 'Missile Launcher Rapid Light', 'Missile Launcher Heavy', 'Missile Launcher Heavy Assault']

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { GROUPS.any? { |g| m.item.group == g } },
          :max_velocity,
          skill_lvl * bonus
        )
      end
    end
  end
end
