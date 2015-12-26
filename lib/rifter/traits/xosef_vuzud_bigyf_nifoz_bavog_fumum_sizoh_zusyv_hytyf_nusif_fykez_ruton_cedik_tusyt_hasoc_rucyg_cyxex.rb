module Rifter
  module Traits
    class XosefVuzudBigyfNifozBavogFumumSizohZusyvHytyfNusifFykezRutonCedikTusytHasocRucygCyxex < Trait
      # used in 6 ships
      description 'bonus to <a href=showinfo:3303>Small Energy Turret</a> optimal range'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Small Energy Turret') },
          :optimal,
          skill_lvl * bonus
        )
      end
    end
  end
end
