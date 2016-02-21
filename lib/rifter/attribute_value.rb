# frozen_string_literal: true
module Rifter
  class AttributeValue
    attr_reader :id, :value, :name, :category, :stackable

    def initialize(row)
      @id = row[:attributeID]
      @value = row[:valueFloat] || row[:valueInt]
      @name = row[:attributeName]
      @category = row[:categoryName]
      @stackable = row[:stackable] == 1
      IceNine.deep_freeze! self
    end
  end
end
