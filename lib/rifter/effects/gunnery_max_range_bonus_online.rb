module Rifter
  module Effects
    class GunneryMaxRangeBonusOnline < Effect
      description 'Tracking Enhancer'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Gunnery') },
          :optimal,
          miscellaneous_attributes.max_range_bonus,
          stacking_penalty: true
        )
      end
    end
  end
end
