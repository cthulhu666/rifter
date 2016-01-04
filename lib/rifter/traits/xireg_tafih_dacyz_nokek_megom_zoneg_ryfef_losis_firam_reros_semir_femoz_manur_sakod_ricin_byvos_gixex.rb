module Rifter
  module Traits
    class XiregTafihDacyzNokekMegomZonegRyfefLosisFiramRerosSemirFemozManurSakodRicinByvosGixex < Trait
      description 'bonus to <a href=showinfo:3309>Large Energy Turret</a> tracking speed'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Energy Turret') },
          :tracking_speed,
          bonus * skill_lvl
        )
      end
    end
  end
end
