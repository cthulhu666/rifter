module Rifter
  module Traits
    class XukarPanumVadapNogulTimamSezabZyhypSyrunLucigMegydCyvucNunacVisicLuvynHomazVevizDuxix < Trait
      description 'bonus to <a href=showinfo:3450>Afterburner</a> velocity bonus'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Afterburner') },
          :speed_factor,
          bonus * skill_lvl
        )
      end
    end
  end
end
