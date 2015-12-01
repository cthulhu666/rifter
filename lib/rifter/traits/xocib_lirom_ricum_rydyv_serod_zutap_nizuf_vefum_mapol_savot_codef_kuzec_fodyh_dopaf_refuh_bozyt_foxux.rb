module Rifter
  module Traits
    class XocibLiromRicumRydyvSerodZutapNizufVefumMapolSavotCodefKuzecFodyhDopafRefuhBozytFoxux < Trait
      # used in 3 ships
      description 'penalty to missile flight time'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.item.skill_required?('Missile Launcher Operation') },
          :explosion_delay,
          -bonus
        )
      end
    end
  end
end
