module Rifter
  module Traits
    class XugehPevetCumonCidacMahozFysutVimogMulotGynyfCivocPacarDikokHutynSegisBedogRopenKaxex < Trait
      # used in 1 ships
      # bonusText: "reduction in <a href=showinfo:3308>Large Projectile Turret</a> CPU requirement"

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Large Projectile Turret') },
          :cpu_usage,
          -bonus
        )
      end
    end
  end
end
