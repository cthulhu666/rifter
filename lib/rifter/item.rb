# frozen_string_literal: true
module Rifter
  class Item
    attr_reader :required_skills, :name, :group, :category, :type_id, :attributes, :attributes_by_category

    def initialize(inv_type, attributes, effects)
      @inv_type = inv_type
      @type_id, @name, @group, @category = *inv_type.fetch_values(:typeID, :typeName, :groupName, :categoryName)
      @attributes = attributes.each_with_object({}) { |a, e| e[a.name] = a }
      @attributes_by_category = attributes.group_by(&:category)
      @required_skills = _required_skills if @attributes_by_category['Required Skills']
      @effects = effects
      IceNine.deep_freeze! self
    end

    def attribute(name)
      @attributes.fetch name
    end

    private

    def _required_skills
      @attributes_by_category['Required Skills']
        .select { |e| e.name =~ /^requiredSkill[0-9]{1,}$/ }
        .each_with_object({}) do |attr, hash|
        hash[attr.value.to_i] = @attributes["#{attr.name}Level"].value.to_i
      end
    end
  end
end
