module Rifter
module Traits
  class XelalVopihTibutZocolColagPamumZorinBapafRybenGebazTytarHiturBiponNitynPabipGotygGyxex < Trait

    # used in 29 ships
    description "bonus to all armor resistances"

    def effect(fitting:, skill_lvl:)
      Damage::DAMAGE_TYPES.each do |d|
        fitting.boost_attribute(:armor_resonances, -bonus * skill_lvl, nested_property: d)
      end
    end

  end
end

end