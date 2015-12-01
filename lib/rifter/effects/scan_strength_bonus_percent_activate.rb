module Rifter
  module Effects
    class ScanStrengthBonusPercentActivate < Effect
      description 'ECCM modules'

      def effect(_attrs, fitting:, fitted_module:)
        ShipFitting::SCANNER_TYPE.each do |t|
          fitting.boost_attribute(
            "#{t}_strength",
            fitted_module["scan_#{t}_strength_percent"]
          )
        end
      end
    end
  end
end
