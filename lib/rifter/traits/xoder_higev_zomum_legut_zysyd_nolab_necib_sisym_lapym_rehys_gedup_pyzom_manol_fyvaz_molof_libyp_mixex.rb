module Rifter
module Traits
  class XoderHigevZomumLegutZysydNolabNecibSisymLapymRehysGedupPyzomManolFyvazMolofLibypMixex < Trait

    # used in 20 ships
    description "bonus to <a href=showinfo:3301>Small Hybrid Turret</a> optimal range"

    def effect(fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Small Hybrid Turret') },
        :optimal,
        bonus * skill_lvl
      )

    end

  end
end

end