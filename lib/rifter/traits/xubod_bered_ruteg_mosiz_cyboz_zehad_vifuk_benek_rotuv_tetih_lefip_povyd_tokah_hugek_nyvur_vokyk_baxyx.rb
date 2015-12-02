module Rifter
  module Traits
    class XubodBeredRutegMosizCybozZehadVifukBenekRotuvTetihLefipPovydTokahHugekNyvurVokykBaxyx < Trait
      # used in 7 ships
      description 'bonus to <a href=showinfo:3304>Medium Hybrid Turret</a> tracking speed'

      def effect(fitting:, skill_lvl:)
        fitting.boost_module_attribute(
          -> (m) { m.ship_module.skill_required?('Medium Hybrid Turret') },
          :tracking_speed,
          bonus * skill_lvl
        )
      end
    end
  end
end
