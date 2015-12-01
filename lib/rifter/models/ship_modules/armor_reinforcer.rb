module Rifter
  module ShipModules
    class ArmorReinforcer < ShipModule
      delegate :armor_hp_bonus_add, to: :miscellaneous_attributes
    end
  end
end
