module Rifter
module Effects
  class DroneDamageBonusOnline < Effect

    description "Used by modules named like Drone Damage Amplifier"

    def effect(attrs, fitting:, fitted_module:)
      fitting.drones.each do |drone|
        drone.boost_attribute(
            :damage_multiplier,
            miscellaneous_attributes.drone_damage_bonus,
            stacking_penalty: true,
        )
      end
    end

  end
end

end