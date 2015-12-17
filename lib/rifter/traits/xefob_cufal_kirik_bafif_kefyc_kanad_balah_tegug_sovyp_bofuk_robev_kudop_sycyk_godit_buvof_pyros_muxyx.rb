module Rifter
  module Traits
    class XefobCufalKirikBafifKefycKanadBalahTegugSovypBofukRobevKudopSycykGoditBuvofPyrosMuxyx < Trait
      description 'reduction in <a href=showinfo:3307>Large Hybrid Turret</a> CPU requirement'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Large Hybrid Turret') },
          :cpu_usage,
          -bonus
        )
      end
    end
  end
end
