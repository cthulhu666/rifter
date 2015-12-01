module Rifter
  module Effects
    class LongRangeTargetingMaxTargetRangeBonusPostPercentMaxTargetRangeLocationShipGroupElectronic < Effect
      description 'Long Range Targeting skill'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        fitting.boost_attribute(:max_target_range,
                                skill_lvl * miscellaneous_attributes.max_target_range_bonus)
      end
    end
  end
end
