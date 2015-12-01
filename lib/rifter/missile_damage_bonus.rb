module Rifter
  class MissileDamageBonus
    SKILL_TO_LAUNCHER_CLASS_MAPPING = {
      'Rockets' => ShipModules::MissileLauncherRocket,
      'Light Missiles' => [ShipModules::MissileLauncherLight, ShipModules::MissileLauncherRapidLight],
      'Heavy Missiles' => [ShipModules::MissileLauncherHeavy, ShipModules::MissileLauncherRapidHeavy],
      'Heavy Assault Missiles' => [ShipModules::MissileLauncherHeavyAssault],
      'Cruise Missiles' => [ShipModules::MissileLauncherCruise],
      'Torpedoes' => [ShipModules::MissileLauncherTorpedo]
    }

    attr_reader :dmg_type, :skill, :skill_level, :fitting

    def initialize(damage_type:, skill:, skill_lvl:, fitting:)
      @dmg_type = damage_type
      @skill = skill
      @skill_level = skill_lvl
      @fitting = fitting
    end

    def apply
      fitting.fitted_modules(klass: launcher_klass).each do |m|
        m.alpha_dmg *= { dmg_type => 1.0 + (skill.miscellaneous_attributes.damage_multiplier_bonus * skill_level / 100.0) }
      end
    end

    private

    def launcher_klass
      @klass ||= (SKILL_TO_LAUNCHER_CLASS_MAPPING[skill.name] || Ship)
    end
  end
end
