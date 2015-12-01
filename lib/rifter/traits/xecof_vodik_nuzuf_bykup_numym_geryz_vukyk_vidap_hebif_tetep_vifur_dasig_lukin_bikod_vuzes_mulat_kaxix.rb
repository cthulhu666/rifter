module Rifter
  module Traits
    class XecofVodikNuzufBykupNumymGeryzVukykVidapHebifTetepVifurDasigLukinBikodVuzesMulatKaxix < Trait
      # used in 4 ships
      description 'bonus to <a href=showinfo:3307>Large Hybrid Turret</a> optimal range'

      def effect(fitting:, skill_lvl:)
        %i(optimal).each do |s|
          fitting.boost_module_attribute(
            -> (m) { m.ship_module.skill_required?('Large Hybrid Turret') },
            s, bonus
          )
        end
      end
    end
  end
end
