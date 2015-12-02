module Rifter
  module Traits
    class XolapFotefBahezZasemSamemRutulLopupMivabMurizBemobHozifDyletHonazZozarBylorSidicKaxox < Trait
      # used in 21 ships
      description 'bonus to <a href=showinfo:3301>Small Hybrid Turret</a> tracking speed'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Small Hybrid Turret') },
          :tracking_speed,
          bonus * skill_lvl
        )
      end
    end
  end
end
