module Rifter
module Effects
  class EnergyManagementCapacitorBonusPostPercentCapacityLocationShipGroupCapacitorCapacityBonus < Effect

    def effect(attributes, fitting:, fitted_module:)
      fitting.boost_attribute(:capacitor_capacity, miscellaneous_attributes.capacitor_capacity_bonus, type: :percent)
    end

    def skill_effect(attributes, fitting:, skill_lvl:)
      fitting.boost_attribute(:capacitor_capacity, miscellaneous_attributes.capacitor_capacity_bonus * skill_lvl, type: :percent)
    end

  end
end

end