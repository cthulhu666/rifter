module Rifter
  module Traits
    class XodisBibumGacanLysocTekemZigehFuricMenokComytFucesCodasHycozFapanRyfimGohasDotypVuxox < Trait
      # used in 32 ships
      description 'reduction in <a href=showinfo:3454>Microwarpdrive</a> signature radius penalty'

      def effect(fitting:, skill_lvl:)
        fitting.propulsion_mods(:microwarpdrive).each do |mwd|
          # this can't be done via ShipModule#boost_attribute because it has to be adjusted early
          mwd.signature_radius_bonus -= bonus / 100.0 * mwd.signature_radius_bonus
        end
      end
    end
  end
end
