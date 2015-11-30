module Rifter
module ShipModules
  class PropulsionModule < ShipModule

    scope :afterburners, -> { where('miscellaneous_attributes.deadspace_unsafe' => {:$ne => 1}) }
    scope :microwarpdrives, -> { where('miscellaneous_attributes.deadspace_unsafe' => {:$eq => 1}) }

    ATTRIBUTES = %i(speed_factor speed_boost_factor mass_addition signature_radius_bonus)

    delegate *ATTRIBUTES, to: :miscellaneous_attributes

    def setup(fitted_module)
      fitted_module.speed_boost = 0
      ATTRIBUTES.each { |a| fitted_module[a] = miscellaneous_attributes[a] }
    end
  end
end

end