module Rifter
  module Traits
    class XebavFesolPezybZupevLykofNozasNibifKycyzHezekTevakRygemZynycSobebGifucTacucGahosPexox < Trait
      # used in 9 ships
      description 'bonus to Rapid <a href=showinfo:3321>Light Missile</a>, <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> Launcher rate of fire'

      GROUPS = ['Missile Launcher Rapid Light', 'Missile Launcher Heavy', 'Missile Launcher Heavy Assault']

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { GROUPS.any? { |g| m.item.group == g } },
          :speed,
          - skill_lvl * bonus
        )
      end
    end
  end
end
