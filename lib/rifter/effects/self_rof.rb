module Rifter
  module Effects
    class SelfRof < Effect
      description 'Used by skills: Rocket Specialization, Torpedo Specialization etc'

      def skill_effect(_attrs, fitting:, skill_lvl:)
        multiplier = 1 + miscellaneous_attributes.rof_bonus * skill_lvl / 100.0
        launchers(fitting).each do |l|
          l.speed *= multiplier
        end
      end

      def launchers(fitting)
        fitting.launchers.select do |l|
          l.ship_module.skill_required?(skill)
        end
      end

      alias_method :skill, :mod
    end
  end
end
