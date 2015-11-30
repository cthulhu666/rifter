module Rifter
  class Character
    include Mongoid::Document
    include Mongoid::Timestamps::Short
    store_in collection: 'characters'

    class CharacterSkill
      include Mongoid::Document

      embedded_in :character, class_name: 'Rifter::Character'

      belongs_to :skill
      field :level, type: Integer

      def effect(miscellaneous_attributes, fitting:)
        effects.each { |e| e.skill_effect(miscellaneous_attributes, fitting: fitting, skill_lvl: level) }
      end

      def inspect
        "<#{skill.name}:#{level}>"
      end

      def effects
        @effects ||= skill.the_effects.select { |e| e.respond_to?(:skill_effect) }
      end

    end

    embeds_many :character_skills, class_name: 'Rifter::Character::CharacterSkill'

    field :name, type: String
    field :eve_id, type: String

    field :api_key_id, type: String
    field :api_key_code, type: String

    class << self
      def perfect_skills_character
        uniform_skills_character(5)
      end

      def uniform_skills_character(lvl)
        create do |c|
          Skill.relevant.each do |s|
            c.character_skills.build(skill: s, level: lvl)
          end
        end
      end
    end

    def api
      @api ||= Eve::API.new(key_id: api_key_id, verification_code: api_key_code)
    end

    def skills_map
      @skills_map ||= character_skills.inject({}) { |h, s| h[s.skill.name] = s.level; h }.freeze
      @skills_map
    end

    def skill_level(skill)
      skill_name = skill.is_a?(String) ? skill : skill.name
      skills_map[skill_name] || 0
    end

    def relevant_character_skills
      @relevant_character_skills ||=
          character_skills.select { |s| s.skill.group.in?(Skill::RELEVANT_GROUPS) }.freeze
    end

    def fetch_name
      self.name = char_sheet.name
    end

    def fetch_skills
      char_sheet.skills.each do |skill|
        if s = Skill.relevant.where(type_id: skill.typeID.to_i).first
          character_skills.build(skill: s, level: skill.level)
        end
      end
    end

    def char_sheet
      @character_sheet ||= api.character_sheet(character_id: eve_id)
    end

  end
end
