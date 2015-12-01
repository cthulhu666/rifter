module Rifter
  module Turret
    extend ActiveSupport::Concern
    using Refinements

    WEAPON_TYPES = %w(pulse beam autocannon artillery blaster railgun)
    # result of `ShipModule.where(:charge_size.exists => true).pluck(:weapon_type).uniq`

    included do
      field :weapon_type, type: String
      field :charge_size, type: Integer

      has_and_belongs_to_many :charges

      index(charge_ids: 1)
      index(weapon_type: 1)

      before_save do
        self.charge_size = begin
                             miscellaneous_attributes.charge_size.to_i
                           rescue
                             nil
                           end
      end
    end

    def charge_valid?(charge)
      charge.id.in?(charge_ids)
    end

    def infer_weapon_type
      fail 'Implement in subclasses'
    end

    def setup(fitted_module)
      %i(speed falloff damage_multiplier tracking_speed optimal_sig_radius).each do |s|
        fitted_module[s] = miscellaneous_attributes[s]
      end
      fitted_module[:optimal] = miscellaneous_attributes.max_range
      class << fitted_module
        include FittedModuleInstanceMethods
      end
    end

    def inspect
      "#<#{self.class}(#{weapon_type}) _id: #{id}, name: #{name}, meta_level: #{meta_level}>"
    end

    module FittedModuleInstanceMethods
      def volley
        if self['charge']
          charge.damage * damage_multiplier
        else
          Damage.new
        end
      end

      def rof
        (speed / 1000.0)**-1
      end

      def dps
        volley * rof
      end

      # see https://github.com/DarkFenX/Pyfa/blob/d60b288e0ea7313f5d6aeb476430d0d928f6aa79/eos/graph/fitDps.py#L111
      def chance_to_hit(target:, distance:, angle:, velocity:)
        transversal = Math.sin(angle.to_rad) * velocity
        tracking_eq = (((transversal / (distance * tracking_speed)) *
            (optimal_sig_radius / target.signature_radius))**2)
        range_eq = (([0, distance - optimal].max) / falloff)**2
        0.5**(tracking_eq + range_eq)
      end
    end
  end
end
