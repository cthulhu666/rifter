module Rifter
module Traits
  class XogapKafetNikifKisalNuruvDovypFiladVefalDanupRepisFozyzGuzabMebyfCebyrVadelZipavTexix < Trait

    # used in 18 ships
    description "bonus to <a href=showinfo:3308>Large Projectile Turret</a> rate of fire"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
                 -> (m) { m.item.skill_required?('Large Projectile Turret') },
                 :speed,
                 -bonus * skill_lvl
      )
    end

  end
end

end