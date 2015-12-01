module Rifter
module Traits
  class XefirBykamZekyhBokefPepavHezubPufipLezutMotuzHypavHativBizazFedafZybisSeradMypelMixux < Trait

    # used in 1 ships (Muninn)
    description "bonus to <a href=showinfo:3305>Medium Projectile Turret</a> optimal range"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Medium Projectile Turret') },
        :optimal,
        bonus * skill_lvl
      )
    end

  end
end

end