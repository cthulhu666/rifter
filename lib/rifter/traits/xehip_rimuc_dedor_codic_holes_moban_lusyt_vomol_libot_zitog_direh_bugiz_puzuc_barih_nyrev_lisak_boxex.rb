module Rifter
module Traits
  class XehipRimucDedorCodicHolesMobanLusytVomolLibotZitogDirehBugizPuzucBarihNyrevLisakBoxex < Trait

    # used in 13 ships
    description "bonus to <a href=showinfo:3308>Large Projectile Turret</a> damage"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Large Projectile Turret') },
        :damage_multiplier,
        bonus * skill_lvl
      )
    end

  end
end

end