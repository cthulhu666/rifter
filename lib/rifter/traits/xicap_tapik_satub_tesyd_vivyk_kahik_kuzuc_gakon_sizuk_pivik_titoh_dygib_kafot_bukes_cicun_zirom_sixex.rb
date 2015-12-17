module Rifter
  module Traits
    class XicapTapikSatubTesydVivykKahikKuzucGakonSizukPivikTitohDygibKafotBukesCicunZiromSixex < Trait
      # used in 1 ships
      description 'reduction in <a href=showinfo:3309>Large Energy Turret</a> CPU requirement'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Large Energy Turret') },
          :cpu_usage,
          -bonus
        )
      end
    end
  end
end
