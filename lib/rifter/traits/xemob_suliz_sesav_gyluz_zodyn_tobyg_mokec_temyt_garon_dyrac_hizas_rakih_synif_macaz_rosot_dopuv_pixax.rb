module Rifter
  module Traits
    class XemobSulizSesavGyluzZodynTobygMokecTemytGaronDyracHizasRakihSynifMacazRosotDopuvPixax < Trait
      # used in 1 ship: Hurricane
      description 'bonus to <a href=showinfo:3305>Medium Projectile Turret</a> optimal range and falloff'

      def effect(fitting:, skill_lvl:)
        %i(optimal falloff).each do |s|
          fitting.boost_module_attribute(
            -> (m) { m.ship_module.skill_required?('Medium Projectile Turret') },
            s, bonus
          )
        end
      end
    end
  end
end
