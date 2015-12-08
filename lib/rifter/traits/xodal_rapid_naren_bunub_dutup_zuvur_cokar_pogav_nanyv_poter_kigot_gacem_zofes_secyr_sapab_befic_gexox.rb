module Rifter
  module Traits
    class XodalRapidNarenBunubDutupZuvurCokarPogavNanyvPoterKigotGacemZofesSecyrSapabBeficGexox < Trait

      description 'bonus to <a href=showinfo:3320>Rocket</a> explosion velocity'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Missile Launcher Rocket' },
          :aoe_velocity,
          bonus * skill_lvl
        )
      end
    end
  end
end
