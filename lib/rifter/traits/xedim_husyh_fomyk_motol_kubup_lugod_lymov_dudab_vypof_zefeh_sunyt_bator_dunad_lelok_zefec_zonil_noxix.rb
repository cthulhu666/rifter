module Rifter
  module Traits
    class XedimHusyhFomykMotolKubupLugodLymovDudabVypofZefehSunytBatorDunadLelokZefecZonilNoxix < Trait
      # used in 17 ships

      description 'bonus to <a href=showinfo:3307>Large Hybrid Turret</a> damage'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Hybrid Turret') },
          :damage_multiplier,
          bonus * skill_lvl
        )
      end
    end
  end
end
