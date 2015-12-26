module Rifter
  module Traits
    class XepelHeguvHepyzBynirCuhisKidimCimohNihyzVihukNuvurDafudSacahTovavZehapHymasFykarKixax < Trait
      # used in 11 ships
      description 'reduction in <a href=showinfo:3303>Small Energy Turret</a> activation cost'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Small Energy Turret') },
          :tracking_speed,
          skill_lvl * bonus
        )
      end
    end
  end
end
