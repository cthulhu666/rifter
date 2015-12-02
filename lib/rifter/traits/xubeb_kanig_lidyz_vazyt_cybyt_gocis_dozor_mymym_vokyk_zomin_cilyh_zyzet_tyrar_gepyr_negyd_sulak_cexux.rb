module Rifter
  module Traits
    class XubebKanigLidyzVazytCybytGocisDozorMymymVokykZominCilyhZyzetTyrarGepyrNegydSulakCexux < Trait
      # used in 3 ships
      description 'bonus to <a href=showinfo:3324>Heavy Missile</a> and <a href=showinfo:25719>Heavy Assault Missile</a> explosion radius'

      GROUP = ['Missile Launcher Heavy', 'Missile Launcher Heavy Assault']

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
