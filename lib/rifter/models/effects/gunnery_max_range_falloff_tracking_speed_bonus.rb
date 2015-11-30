module Rifter
module Effects
  class GunneryMaxRangeFalloffTrackingSpeedBonus < Effect

    description "Tracking Computer"

    def effect(attrs, fitting:, fitted_module:)
      [['falloff', 'falloff_bonus'],
       ['optimal', 'max_range_bonus'],
      # TODO: tracking speed ['', '']
      ].each do |k, v|
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Gunnery') },
          k,
          fitted_module[v],
          stacking_penalty: true
        )
      end
    end

  end
end

end