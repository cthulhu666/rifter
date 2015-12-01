module Rifter
module Traits
  class XemilMyrodBidivMidurKusyrPypurTozygHutacTilugSyzuvCygucZoranLimosCumesKuparKopukFyxex < Trait

    # used in 1 ships
    description "reduction in <a href=showinfo:3308>Large Projectile Turret</a> powergrid requirement"

    def effect(fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Large Projectile Turret') },
        :power_usage,
        -bonus
      )
    end

  end
end

end