# frozen_string_literal: true
module Rifter
  class Attributes # TODO: singleton?
    AttributeNotFound = Class.new(StandardError)

    def self.[](name)
      attributes[name] || fail(AttributeNotFound, name)
    end

    def self.attributes
      @attributes ||= begin
        attrs = DB[:dgmAttributeTypes].each_with_object({}) do |row, hash|
          hash[row[:attributeName]] = row[:attributeID]
        end
        IceNine.deep_freeze(attrs)
      end
    end
  end
end
