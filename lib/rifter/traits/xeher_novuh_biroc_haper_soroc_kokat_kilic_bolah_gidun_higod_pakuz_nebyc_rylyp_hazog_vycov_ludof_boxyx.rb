module Rifter
module Traits
  class XeherNovuhBirocHaperSorocKokatKilicBolahGidunHigodPakuzNebycRylypHazogVycovLudofBoxyx < Trait

    # used in 8 ships
    description "bonus to kinetic and thermal missile damage"

    def effect(fitting:, skill_lvl:)
      multiplier = bonus * skill_lvl / 100.0
      fitting.launchers.each do |l|
        l.alpha_dmg *= {kinetic: 1.0 + multiplier, thermal: 1.0 + multiplier}
      end
    end

  end
end

end