module Rifter
  module Effects
    class CpuNeedBonusEffectLasers < Effect
      description 'Algid Energy Administrations Unit'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_module_attribute(
          -> (m) { m.item.group == 'Energy Weapon' },
          :cpu_usage,
          miscellaneous_attributes.cpu_need_bonus
        )
      end
    end
  end
end
