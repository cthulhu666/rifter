module Rifter
  module Traits
    class XunocMirufZahydBelufFazucBekenZesihPitanByfipKumytRygilBudihVupozMitopTuvytGilufZexex < Trait
      # used in 1 ships
      description 'bonus to <a href=showinfo:3326>Cruise Missile</a> and <a href=showinfo:3325>Torpedo</a> explosion radius'

      GROUP = ['Missile Launcher Cruise', 'Missile Launcher Torpedo']

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group.in?(GROUP) },
          :aoe_cloud_size,
          skill_lvl * -bonus
        )
      end
    end
  end
end
