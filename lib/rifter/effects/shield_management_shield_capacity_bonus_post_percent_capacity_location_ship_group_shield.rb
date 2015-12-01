module Rifter
module Effects
  class ShieldManagementShieldCapacityBonusPostPercentCapacityLocationShipGroupShield < Effect

    description "Core Defense Field Extender rig, Shield Management skill"

    def effect(attrs, fitting:, fitted_module:)
      fitting.boost_attribute(
          :shield_capacity,
          miscellaneous_attributes.shield_capacity_bonus)
    end

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_attribute(
          :shield_capacity,
          miscellaneous_attributes.shield_capacity_bonus * skill_lvl)
    end

  end
end

end