module Rifter
module Traits
  class XutazMyrydMucudHilefMapydDasetZazogHitefTalumKovocKamigFabapPamorZekypFizyvZumusSuxux < Trait

    # used in 10 ships
    description "bonus to <a href=showinfo:3306>Medium Energy Turret</a> damage"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Medium Energy Turret') },
        :damage_multiplier,
        bonus * skill_lvl,
      )
    end

  end
end

end