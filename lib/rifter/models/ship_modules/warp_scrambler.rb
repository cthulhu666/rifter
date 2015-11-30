module Rifter
module ShipModules
  class WarpScrambler < ShipModule

    scope :warp_scramblers, -> { where(:effects.in => ['warpScrambleBlockMWDWithNPCEffect']) }
    scope :warp_disruptors, -> { where(:effects.in => ['warpScramble']) }

    def setup(fitted_module)
      %i(max_range warp_scramble_strength capacitor_need duration).each do |s|
        fitted_module[s] = miscellaneous_attributes[s]
      end
      class << fitted_module
        include FittedModuleInstanceMethods
      end
    end

    def type
      s = 'warpScrambleBlockMWDWithNPCEffect'.in?(effects) ? 'scram' : 'point'
      ActiveSupport::StringInquirer.new(s)
    end

    module FittedModuleInstanceMethods
      def overload_max_range
        if bonus = item.miscellaneous_attributes.try(:overload_range_bonus)
          (100 + bonus) / 100.0 * max_range
        end
      end
    end

  end
end

end