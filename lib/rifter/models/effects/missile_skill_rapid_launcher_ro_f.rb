module Rifter
module Effects
  class MissileSkillRapidLauncherRoF < Effect

  description "Used by skills: Rapid Launch, Missile Launcher Operation"

  def skill_effect(attrs, fitting:, skill_lvl:)
    fitting.boost_module_attribute(
               -> (m) { m.item.skill_required?('Missile Launcher Operation') },
               :speed,
               miscellaneous_attributes.rof_bonus * skill_lvl
    )
  end

  end
end

end