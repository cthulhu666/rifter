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
      effects = effects(inv_type[:typeID]).map { |e| e[:effectName] }
      market_groups = market_groups(inv_type[:marketGroupID]).map { |e| e[:marketGroupName]}.reverse
      Item.new(inv_type, attributes, effects, market_groups)
    end

    def where(hash)
      inv_type(hash).map do |i|
        attributes = attributes(i[:typeID]).map { |e| AttributeValue.new(e) }
        Item.new(i, attributes, [], []) # TODO: effects; don't duplicate code
      end
    end

    private

    def db
      DB
    end

    def inv_type(type_id_or_hash)
      hash = case type_id_or_hash
             when Fixnum
               { invTypes__typeID: type_id_or_hash }
             when String
               { typeName: type_id_or_hash }
             when Hash
               type_id_or_hash
             end
      db[:invTypes]
        .join(:invGroups, groupID: :groupID)
        .join(:invCategories, categoryID: :categoryID)
        .left_join(:invMetaTypes, invTypes__typeID: :invMetaTypes__typeID)
        .left_join(:invMetaGroups, metaGroupID: :metaGroupID)
        .where(hash).select(:invTypes__typeID, :invTypes__marketGroupID, :invTypes__typeName,
                            :invGroups__groupName, :invCategories__categoryName)
    end

    def attributes(type_id)
      db[:dgmTypeAttributes]
        .join(:dgmAttributeTypes, attributeID: :attributeID)
        .left_join(:dgmAttributeCategories, categoryID: :categoryID)
        .where(typeID: type_id)
        .select(:dgmTypeAttributes__attributeID, :categoryName, :attributeName, :valueInt, :valueFloat, :stackable)
        .all
    end

    def effects(type_id)
      db[:dgmTypeEffects]
        .join(:dgmEffects, effectID: :effectID)
        .where(typeID: type_id)
        .select(:effectName, :modifierInfo)
    end

    def market_groups(market_group_id)
      group = db[:invMarketGroups].where(marketGroupID: market_group_id).first
      parent_id = group[:parentGroupID]
      return [group] if parent_id.nil?
      [group] + market_groups(parent_id)
    end
  end
end
