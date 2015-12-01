module Rifter
  module ShipModules
    class DamageControl < ShipModule
      DAMAGE_TYPES.each do |dmg_type|
        delegate "shield_#{dmg_type}_damage_resonance", to: :miscellaneous_attributes
      end
    end
  end
end
