module Rifter
module Effects
  class MissileBombardmentMaxFlightTimeBonusPostPercentExplosionDelayOwnerCharModulesRequiringMissileLauncherOperation < Effect

    description "Rocket Fuel Cache Partition rigs, Missile Bombardment skill"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :explosion_delay,
        miscellaneous_attributes.max_flight_time_bonus,
        stacking_penalty: true
      )
    end

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.skill_required?('Missile Launcher Operation') },
        :explosion_delay,
        miscellaneous_attributes.max_flight_time_bonus * skill_lvl
      )
    end

  end
end

end