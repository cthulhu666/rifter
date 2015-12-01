module Rifter
  module Traits
    class XuzirSypakKerubLunikSohydDukehRegirPibebNihahKaguzZikacHytenKemifPafetDudebDabyfNoxyx < Trait
      # used in 7 ships
      description 'bonus to <a href=showinfo:3308>Large Projectile Turret</a> falloff'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Large Projectile Turret') },
          :falloff,
          bonus * skill_lvl
        )
      end
    end
  end
end
