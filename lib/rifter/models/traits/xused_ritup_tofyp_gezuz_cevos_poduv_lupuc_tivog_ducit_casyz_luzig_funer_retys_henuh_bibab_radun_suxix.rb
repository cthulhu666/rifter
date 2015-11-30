module Rifter
module Traits
  class XusedRitupTofypGezuzCevosPoduvLupucTivogDucitCasyzLuzigFunerRetysHenuhBibabRadunSuxix < Trait

    # used in 3 ships
    description "bonus to <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> damage"

    GROUPS = ['Missile Launcher Rapid Heavy', 'Missile Launcher Heavy', 'Missile Launcher Heavy Assault']

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { GROUPS.any? { |g| m.item.group == g } },
        :alpha_dmg,
        skill_lvl * bonus
      )
    end

  end
end

end