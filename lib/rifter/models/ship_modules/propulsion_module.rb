module Rifter
  module ShipModules
    class PropulsionModule < ShipModule
      scope :afterburners, -> { where('miscellaneous_attributes.deadspace_unsafe' => { :$ne => 1 }) }
      scope :microwarpdrives, -> { where('miscellaneous_attributes.deadspace_unsafe' => { :$eq => 1 }) }

      copy_attributes :capacitor_need, :duration, :speed_factor,
                      :speed_boost_factor, :mass_addition, :signature_radius_bonus

      def setup(fitted_module)
        super
        fitted_module.speed_boost = 0
        class << fitted_module
          include FittedModuleInstanceMethods
        end
      end

      module FittedModuleInstanceMethods
        def cap_usage
          capacitor_need / duration * 1000.0
        end
      end
    end
  end
end
