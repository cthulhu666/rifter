module Rifter
  module Traits
    class XikevFyretHipyfPaconByretDybebPyfytLagivBapikRulemCynigVoninGamorLyrerDiborZecykTyxox < Trait
      # used in 2 ships
      description 'bonus to ship armor hitpoints'

      def effect(fitting:, skill_lvl:)
        fitting.boost_attribute(:armor_capacity, skill_lvl * bonus)
      end
    end
  end
end
