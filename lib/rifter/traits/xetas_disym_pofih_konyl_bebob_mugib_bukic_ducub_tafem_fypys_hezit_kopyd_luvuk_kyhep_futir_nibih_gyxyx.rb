module Rifter
module Traits
  class XetasDisymPofihKonylBebobMugibBukicDucubTafemFypysHezitKopydLuvukKyhepFutirNibihGyxyx < Trait

    # used in 5 ships
    description "bonus to <a href=showinfo:3306>Medium Energy Turret</a> rate of fire"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Medium Energy Turret') },
        :speed,
        -bonus * skill_lvl,
      )
    end

  end
end

end