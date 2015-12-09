module Rifter
  module Traits
    class XulocNidokZepypVugupKofekGuzalBibarBaracLozehKabekGosihDalypGevefSidocHydynFifuhGexax < Trait
      # used in 1 ships
      description 'bonus to <a href=showinfo:3306>Medium Energy Turret</a>, <a href=showinfo:3304>Medium Hybrid Turret</a> and <a href=showinfo:3305>Medium Projectile Turret</a> damage'

      SKILLS = ['Medium Energy Turret', 'Medium Hybrid Turret', 'Medium Projectile Turret']

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { SKILLS.any? { |s| m.item.skill_required?(s) } },
          :damage_multiplier,
          skill_lvl * bonus
        )
      end
    end
  end
end
