module Rifter
  module Effects
    class ResistanceKillerShieldArmorAll < Effect
      FULL_RESONANCE = ShipModule::DAMAGE_TYPES.inject({}) { |h, dmg_type| h[dmg_type] = 1.0; h }

      def post_effect(attrs, _opts = {})
        attrs.shield_resonances = FULL_RESONANCE.dup
        attrs.armor_resonances = FULL_RESONANCE.dup
      end
    end
  end
end
