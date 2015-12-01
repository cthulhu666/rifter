module Rifter
  module Traits
    class XupalMuranZolivPyhirHevobDarafBisomFagilPuhatHomolPykisNulagTapovMavikCogovVugakSoxux < Trait
      # used in 3 ships
      description 'bonus to <a href=showinfo:3435>warp scrambler</a> and <a href=showinfo:3435>warp disruptor</a> maximum range'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.is_a?(ShipModules::WarpScrambler) },
          :max_range,
          bonus * skill_lvl
        )
      end
    end
  end
end
