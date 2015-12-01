module Rifter
  module Traits
    class XinicFagusKabibFakepGirulPigilCapesFezunLuhevPynolDydulHorezByhubBetigFirigHorahFuxyx < Trait
      # used in 9 ships
      description 'bonus to <a href=showinfo:3321>Light Missile</a> and <a href=showinfo:3320>Rocket</a> max velocity'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { ['Rockets', 'Light Missiles'].any? { |s| m.item.skill_required?(s) } },
          :max_velocity,
          bonus
        )
      end
    end
  end
end
