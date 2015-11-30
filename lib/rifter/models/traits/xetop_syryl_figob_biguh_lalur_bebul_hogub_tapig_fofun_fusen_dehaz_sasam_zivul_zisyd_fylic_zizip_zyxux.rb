module Rifter
module Traits
  class XetopSyrylFigobBiguhLalurBebulHogubTapigFofunFusenDehazSasamZivulZisydFylicZizipZyxux < Trait

    # used in 24 ships
    description "bonus to <a href=showinfo:3302>Small Projectile Turret</a> damage"

    def effect(fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Small Projectile Turret') },
        :damage_multiplier,
        bonus * skill_lvl
      )

    end

  end
end

end