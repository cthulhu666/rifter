module Rifter
module Effects
  class EwSkillTargetPaintingStrengthBonus < Effect

    description "Signature Focusing skill"

    def skill_effect(attrs, fitting:, skill_lvl:)
      fitting.boost_module_attribute(
        -> (m) { m.item.is_a?(ShipModules::TargetPainter) },
        :signature_radius_bonus,
        skill_lvl * miscellaneous_attributes.scan_skill_target_paint_strength_bonus
      )
    end

  end
end

end