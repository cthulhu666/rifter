module Rifter
  class SavedDamageProfile
    include Mongoid::Document
    store_in collection: 'saved_damage_profiles'

    field :label,     type: String
    field :em,        type: Integer
    field :thermal,   type: Integer
    field :kinetic,   type: Integer
    field :explosive, type: Integer

    def to_damage_profile
      DamageProfile.new(em: em, thermal: thermal, kinetic: kinetic, explosive: explosive)
    end
  end
end
