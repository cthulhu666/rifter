module Rifter
  module Traits
    class XocavVagivSusidHukalMefopGydafHodocCelepRufudBogyzLusefBehutHenamPykesMadubZofenCexox < Trait
      # used in 10 ships
      description 'bonus to <a href=showinfo:3304>Medium Hybrid Turret</a> optimal range'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Medium Hybrid Turret') },
          :optimal,
          bonus * skill_lvl
        )
      end
    end
  end
end
