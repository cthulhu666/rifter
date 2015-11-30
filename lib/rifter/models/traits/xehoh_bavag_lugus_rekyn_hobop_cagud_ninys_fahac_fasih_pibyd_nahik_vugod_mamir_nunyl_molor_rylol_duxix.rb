module Rifter
module Traits
  class XehohBavagLugusRekynHobopCagudNinysFahacFasihPibydNahikVugodMamirNunylMolorRylolDuxix < Trait

    # used in 4 ships
    description "bonus to <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> Launcher rate of fire"

    def effect(fitting:, skill_lvl:)
      multiplier = bonus * skill_lvl / 100.0
      fitting.launchers.each do |l|
        bonus = l.ship_module.miscellaneous_attributes.speed * multiplier
        l.speed += bonus
      end
    end

  end
end

end