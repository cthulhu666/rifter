module Rifter
  module Effects
    class ShieldCapacityBonusOnline < Effect
      def effect(attrs, _opts = {})
        attrs.shield_capacity += miscellaneous_attributes.capacity_bonus
      end
    end
  end
end
