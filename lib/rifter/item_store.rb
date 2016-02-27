# frozen_string_literal: true
module Rifter
  module ItemStore
    extend self

    def [](id)
      find(id)
    end

    def find(id)
      inv_type = inv_type(id).first
      fail 'Not found' if inv_type.nil?
      attributes = attributes(inv_type[:typeID]).map { |e| AttributeValue.new(e) }
      Item.new(inv_type, attributes)
    end

    def where(hash)
      inv_type(hash).map do |i|
        attributes = attributes(i[:typeID]).map { |e| AttributeValue.new(e) }
        Item.new(i, attributes)
      end
    end

    private

    def db
      DB
    end

    def inv_type(type_id_or_hash)
      hash = case type_id_or_hash
             when Fixnum
               { typeID: type_id_or_hash }
             when String
               { typeName: type_id_or_hash }
             when Hash
               type_id_or_hash
             end
      db[:invTypes]
        .join(:invGroups, groupID: :groupID)
        .join(:invCategories, categoryID: :categoryID)
        .where(hash)
    end

    def attributes(type_id)
      db[:dgmTypeAttributes]
        .join(:dgmAttributeTypes, attributeID: :attributeID)
        .left_join(:dgmAttributeCategories, categoryID: :categoryID)
        .where(typeID: type_id)
        .select(:dgmTypeAttributes__attributeID, :categoryName, :attributeName, :valueInt, :valueFloat, :stackable)
        .all
    end

    #     def effects(type_id)
    #       db[:dgmTypeEffects]
    #         .join(:dgmEffects, effectID: :effectID)
    #         .where(typeID: type_id)
    #         .select(:effectName, :modifierInfo)
    #     end
  end
end
