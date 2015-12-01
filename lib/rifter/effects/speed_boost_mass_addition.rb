module Rifter
  module Effects
    class SpeedBoostMassAddition < Effect
      # SEE: https://github.com/DarkFenX/Pyfa/blob/4e890e1e1d8ba1ecdbe589eaab3d1f68cf001509/eos/effects/speedboostmassaddition.py

      description 'Afterburners'

      def effect(_attrs, fitting:, fitted_module:)
        fitting.boost_attribute(
          :mass,
          fitted_module.mass_addition,
          type: :flat
        )
      end
    end
  end
end
