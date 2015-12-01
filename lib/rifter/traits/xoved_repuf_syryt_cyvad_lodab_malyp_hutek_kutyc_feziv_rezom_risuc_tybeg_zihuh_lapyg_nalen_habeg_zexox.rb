module Rifter
  module Traits
    class XovedRepufSyrytCyvadLodabMalypHutekKutycFezivRezomRisucTybegZihuhLapygNalenHabegZexox < Trait
      # used in 13 ships
      description 'bonus to <a href=showinfo:3302>Small Projectile Turret</a> tracking speed'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Small Projectile Turret') },
          :tracking_speed,
          bonus * skill_lvl
        )
      end
    end
  end
end
