module Rifter
module Traits
  class XusamGifitVepezTevesPalodSufotTegahZysyhCysynKopubGykusBorumPebirTynevZekepMukagVyxix < Trait

    # used in 12 ships
    description "bonus to <a href=showinfo:3305>Medium Projectile Turret</a> damage"

    def effect(fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Medium Projectile Turret') },
        :damage_multiplier, # TODO check this
        bonus * skill_lvl
      )

    end

  end
end

end