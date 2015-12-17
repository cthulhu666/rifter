module Rifter
  module Traits
    class XitotHuzedRivehGyrypVopupDutufFanycKomavCulyhHulosHelyzBidycHonapLibunGecugRizafSoxax < Trait
      description 'reduction in <a href=showinfo:3309>Large Energy Turret</a> powergrid requirement'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Large Energy Turret') },
          :power_usage,
          -bonus
        )
      end
    end
  end
end
