module Rifter
  module Effects
    class MissileGuidanceComputerBonus4 < Effect
      description 'Missile Guidance Computer'

      def effect(_attrs, fitting:, fitted_module:)
        [%w(max_velocity missile_velocity_bonus),
         %w(explosion_delay explosion_delay_bonus),
         %w(aoe_velocity aoe_velocity_bonus),
         %w(aoe_cloud_size aoe_cloud_size_bonus)].each do |k, v|
          fitting.boost_module_attribute(
            -> (m) { m.item.skill_required?('Missile Launcher Operation') },
            k,
            fitted_module[v],
            stacking_penalty: true
          )
        end
      end
    end
  end
end
