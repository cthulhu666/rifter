module Rifter
  module RequiresSkills
    extend ActiveSupport::Concern

    included do
      embeds_many :required_skills, class_name: 'Rifter::RequiredSkill'

      def self.assign_required_skills
        each do |mod|
          mod.required_skills.clear
          # TODO: ShipModule has all attributes directly in miscellaneous_attributes; make it as in Drone
          req_skills = case mod
                       when ShipModule
                         mod.miscellaneous_attributes.attributes
                       when Drone
                         mod.miscellaneous_attributes.required_skills
                       end
          req_skills.select { |k, _v| k =~ /^required_skill[0-9]$/ }.each do |k, v|
            num = k.match(/required_skill([0-9])/)[1]
            lvl = req_skills["required_skill#{num}_level"].to_i
            skill = Skill.unscoped.find_by(type_id: v.to_i)
            mod.required_skills << RequiredSkill.new(skill: skill, level: lvl)
          end
        end
      end
    end

    # returns array of skill names that are missing
    def validate_skills(skills_map)
      required_skills.inject([]) do |arr, s|
        lvl = skills_map[s.skill.name] || 0
        arr << [s.skill, s.level] if s.level > lvl
        arr
      end
    end

    def skill_required?(skill)
      skill_name = skill.is_a?(String) ? skill : skill.name
      @required_skills ||= Hash.new do |h, key|
        h[key] = key.in?(required_skills.map(&:skill).map { |s| s.try(:name) })
      end
      @required_skills[skill_name]
    end
  end
end
