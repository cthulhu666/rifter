module Rifter
  module Traits
    class XonehRucucVyfagSocegPyfizKelehLigunLeladRatefLefevDakezZehycCyzonNutipLegumVokozCixyx < Trait
      # used in 3 ships
      description 'bonus to <a href=showinfo:23594>Sentry Drone</a> and <a href=showinfo:3441>Heavy Drone</a> damage and hitpoints'

      def effect(fitting:, skill_lvl:)
        fitting.drones.select { |d| d.drone.drone_class.in? %i(heavy sentry) }.each do |d|
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
