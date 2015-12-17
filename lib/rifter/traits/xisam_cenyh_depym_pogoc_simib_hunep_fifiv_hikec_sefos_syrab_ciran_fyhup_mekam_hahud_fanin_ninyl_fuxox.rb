module Rifter
  module Traits
    class XisamCenyhDepymPogocSimibHunepFifivHikecSefosSyrabCiranFyhupMekamHahudFaninNinylFuxox < Trait
      description 'reduction in <a href=showinfo:3307>Large Hybrid Turret</a> powergrid requirement'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Large Hybrid Turret') },
          :power_usage,
          -bonus
        )
      end
    end
  end
end
