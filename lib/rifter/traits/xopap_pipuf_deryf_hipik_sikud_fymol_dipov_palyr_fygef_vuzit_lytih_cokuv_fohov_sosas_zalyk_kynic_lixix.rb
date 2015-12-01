module Rifter
  module Traits
    class XopapPipufDeryfHipikSikudFymolDipovPalyrFygefVuzitLytihCokuvFohovSosasZalykKynicLixix < Trait
      # used in 2 ships
      description 'bonus to <a href=showinfo:24241>Light Combat Drone</a> damage and hitpoints'

      def effect(fitting:, skill_lvl:)
        fitting.drones.select { |d| d.drone.drone_class.light? }.each do |d|
          d.boost_attribute(
            :damage_multiplier,
            bonus
          )
        end
        # TODO: hitpoints/mining yield
      end
    end
  end
end
