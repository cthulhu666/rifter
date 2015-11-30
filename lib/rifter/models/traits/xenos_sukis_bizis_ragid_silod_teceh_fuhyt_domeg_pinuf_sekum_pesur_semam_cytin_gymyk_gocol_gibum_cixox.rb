module Rifter
module Traits
  class XenosSukisBizisRagidSilodTecehFuhytDomegPinufSekumPesurSemamCytinGymykGocolGibumCixox < Trait

    # used in 18 ships
    description "bonus to <a href=showinfo:3303>Small Energy Turret</a> damage"

    def effect(fitting:, skill_lvl:)

      fitting.boost_module_attribute(
        -> (m) { m.ship_module.skill_required?('Small Energy Turret') },
        :damage_multiplier, bonus * skill_lvl
      )

    end

  end
end

end