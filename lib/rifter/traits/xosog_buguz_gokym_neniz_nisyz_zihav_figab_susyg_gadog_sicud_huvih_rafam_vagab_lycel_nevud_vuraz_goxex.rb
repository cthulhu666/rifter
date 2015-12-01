module Rifter
module Traits
  class XosogBuguzGokymNenizNisyzZihavFigabSusygGadogSicudHuvihRafamVagabLycelNevudVurazGoxex < Trait

    # used in 40 ships
    description "bonus to all shield resistances"

    def effect(fitting:, skill_lvl:)
      Damage::DAMAGE_TYPES.each do |d|
        fitting.boost_attribute(:shield_resonances, -bonus * skill_lvl, nested_property: d)
      end
    end

  end
end

end