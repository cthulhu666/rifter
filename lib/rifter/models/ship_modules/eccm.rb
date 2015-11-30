module Rifter
module ShipModules
  class ECCM < ShipModule

    def setup(fitted_module)
      ShipFitting::SCANNER_TYPE.each do |t|
        fitted_module["scan_#{t}_strength_percent"] =
            miscellaneous_attributes["scan_#{t}_strength_percent"]
      end
    end

  end
end

end