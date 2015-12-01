module Rifter
  module Traits
    class XirosSyfopCelopRicikBokymCysucFaforSarugLobopLadolKavozHinolNecuhMupafPufotLapirDuxox < Trait
      # used in 1 ships (Cerberus)
      description 'bonus to <a href=showinfo:3321>Light Missile</a>, <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> max flight time'

      CHARGE_GROUPS = ['Light Missile', 'Heavy Missile', 'Heavy Assault Missile', 'Advanced Light Missile', 'Advanced Heavy Assault Missile', 'Advanced Heavy Missile']
      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.respond_to?(:charge) && m.charge.group.in?(CHARGE_GROUPS) },
          :explosion_delay,
          bonus * skill_lvl
        )
      end
    end
  end
end
