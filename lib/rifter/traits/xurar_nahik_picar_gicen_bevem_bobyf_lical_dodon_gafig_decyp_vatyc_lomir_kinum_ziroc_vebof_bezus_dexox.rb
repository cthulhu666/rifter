module Rifter
  module Traits
    class XurarNahikPicarGicenBevemBobyfLicalDodonGafigDecypVatycLomirKinumZirocVebofBezusDexox < Trait
      description 'bonus to <a href=showinfo:3304>Medium Hybrid Turret</a> optimal range and falloff'

      def effect(fitting:, skill_lvl:)
        %i(optimal falloff).each do |s|
          fitting.boost_module_attribute(
            -> (m) { m.ship_module.skill_required?('Medium Hybrid Turret') },
            s,
            bonus * skill_lvl
          )
        end
      end
    end
  end
end
