module Rifter
module ShipModules
  class StasisWeb < ShipModule

    def setup(fitted_module)
      %i(max_range speed_factor capacitor_need duration).each do |s|
        fitted_module[s] = miscellaneous_attributes[s]
      end
      #class << fitted_module
      #  include FittedModuleInstanceMethods
      #end
    end

  end
end

end