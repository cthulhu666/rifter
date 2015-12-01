module Rifter
  module Effects
    class SurgicalStrikeDamageMultiplierBonusPostPercentDamageMultiplierLocationShipGroupProjectileWeapon < Effect
      description 'Surgical Strike skill'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.is_a?(ShipModules::ProjectileWeapon) },
          :damage_multiplier,
          miscellaneous_attributes.damage_multiplier_bonus * skill_lvl
        )
      end
    end
  end
end
