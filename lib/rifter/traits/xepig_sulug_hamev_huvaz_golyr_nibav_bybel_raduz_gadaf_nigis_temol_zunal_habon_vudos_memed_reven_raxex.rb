module Rifter
  module Traits
    class XepigSulugHamevHuvazGolyrNibavBybelRaduzGadafNigisTemolZunalHabonVudosMemedRevenRaxex < Trait
      # used in 2 ships (Gila, Chameleon)
      description 'bonus to <a href=showinfo:33699>Medium Combat Drone</a> damage and hitpoints'

      def effect(fitting:, skill_lvl:)
        fitting.drones.select { |d| d.drone.drone_class.medium? }.each do |d|
          d.boost_attribute(:damage_multiplier, bonus)
          # TODO: hitpoints
        end
      end
    end
  end
end
