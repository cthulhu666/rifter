module Rifter
module ShipModules
  class MissileGuidanceComputer < ShipModule
    include HasCharges

    def setup(fitted_module)
      %i(explosion_delay_bonus missile_velocity_bonus).each do |s|
        fitted_module[s] = miscellaneous_attributes[s]
      end
    end

  end
end

end