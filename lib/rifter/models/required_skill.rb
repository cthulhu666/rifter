module Rifter
  class RequiredSkill
    include Mongoid::Document

    embedded_in :ship_module

    belongs_to :skill

    field :level, type: Integer
  end
end
