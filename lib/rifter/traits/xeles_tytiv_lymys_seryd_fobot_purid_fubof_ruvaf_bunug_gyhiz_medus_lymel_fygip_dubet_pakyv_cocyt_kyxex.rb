module Rifter
  module Traits
    class XelesTytivLymysSerydFobotPuridFubofRuvafBunugGyhizMedusLymelFygipDubetPakyvCocytKyxex < Trait
      # used in 8 ships
      description 'bonus to <a href=showinfo:3302>Small Projectile Turret</a> falloff'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Small Projectile Turret') },
          :falloff,
          bonus * skill_lvl
        )
      end
    end
  end
end
