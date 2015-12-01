module Rifter
  module Traits
    class XubecPozydHogufGylirGasosCogotTinelMifyzMotyzGygesCotyhLorobMolyzLumamRotefFovanVoxix < Trait
      # used in 6 ships
      description 'bonus to <a href=showinfo:3307>Large Hybrid Turret</a> rate of fire'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Hybrid Turret') },
          :speed,
          -bonus * skill_lvl
        )
      end
    end
  end
end
