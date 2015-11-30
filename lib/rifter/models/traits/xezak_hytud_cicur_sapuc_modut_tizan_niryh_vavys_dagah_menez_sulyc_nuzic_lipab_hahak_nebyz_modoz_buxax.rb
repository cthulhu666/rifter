module Rifter
module Traits
  class XezakHytudCicurSapucModutTizanNiryhVavysDagahMenezSulycNuzicLipabHahakNebyzModozBuxax < Trait

    # used in 2 ships
    description "bonus to drone damage and hitpoints"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.ship_module.is_a?(Drone) },
        :damage_multiplier,
        bonus * skill_lvl
      )
      # TODO: hitpoints/mining yield
    end

  end
end

end