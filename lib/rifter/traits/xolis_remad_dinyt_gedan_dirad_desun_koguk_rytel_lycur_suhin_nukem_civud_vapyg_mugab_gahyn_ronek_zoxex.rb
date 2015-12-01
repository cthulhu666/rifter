module Rifter
  module Traits
    class XolisRemadDinytGedanDiradDesunKogukRytelLycurSuhinNukemCivudVapygMugabGahynRonekZoxex < Trait
      # used in 13 ships
      description 'bonus to <a href=showinfo:3305>Medium Projectile Turret</a> rate of fire'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Medium Projectile Turret') },
          :speed,
          -bonus * skill_lvl
        )
      end
    end
  end
end
