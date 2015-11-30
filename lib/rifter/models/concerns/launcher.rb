module Rifter
  module Launcher
    extend ActiveSupport::Concern

    included do
      include HasCharges

      field :weapon_type, type: String

      index({charge_ids: 1}) # TODO: move to HasCharges, but confirm it's necessary first
      index({weapon_type: 1})
    end

    ATTRIBUTES = %i(aoe_cloud_size aoe_velocity explosion_delay max_velocity aoe_damage_reduction_factor aoe_damage_reduction_sensitivity)

    def setup(fitted_module)
      fitted_module['speed'] = miscellaneous_attributes.speed
      if fitted_module['charge']
        ATTRIBUTES.each { |a| fitted_module[a] = fitted_module.charge.miscellaneous_attributes[a] }
      else
        ATTRIBUTES.each { |a| fitted_module[a] = 0 }
      end
      class << fitted_module
        include FittedModuleInstanceMethods
      end
      fitted_module['alpha_dmg'] = fitted_module.raw_alpha_dmg
    end

    def infer_weapon_type
      group.delete(' ').underscore
    end


    module FittedModuleInstanceMethods
      def charges_per_reload
        (ship_module.capacity / charge.volume).floor
      end

      # per second, [without reloads, with_reloads]
      def rate_of_fire
        without_reload = (speed / 1000.0) ** -1
        cpr = charges_per_reload
        t = speed * cpr + reload_time
        with_reload = (t / 1000.0 / cpr)**-1
        [without_reload, with_reload]
      end

      def reload_time
        ship_module.miscellaneous_attributes.reload_time rescue 10 # if not specified, then 10s, according to PyFa
      end

      def volley
        alpha_dmg
      end

      # [without reloads, with_reloads]
      def dps
        return [Damage.new, Damage.new] if self['charge'].nil?
        rof = rate_of_fire
        [alpha_dmg * rof.first, alpha_dmg * rof.last]
      end

      def raw_alpha_dmg
        if self['charge']
          charge.damage
        else
          Damage.new
        end
      end

      def range
        explosion_delay * max_velocity / 1000.0
      end

    end

  end
end
