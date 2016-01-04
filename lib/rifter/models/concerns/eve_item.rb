module EveItem
  extend ActiveSupport::Concern

  included do
    field :name,        type: String
    field :group,       type: String

    field :mass,        type: Float
    field :volume,      type: Float
    field :capacity,    type: Float
    field :base_price,  type: Float
    field :published,   type: Boolean

    # typeID in db dump
    field :type_id, type: Integer
    # parentTypeID in invMetaTypes table
    field :parent_type_id, type: Integer
    # :metaGroupID in invMetaTypes table
    field :meta_group_id, type: Integer

    embeds_one :miscellaneous_attributes, class_name: 'Rifter::MiscellaneousAttributes'

    scope :group, ->(name) { where(group: name) }
    scope :published, -> { where(published: true) }
    default_scope -> { published }

    index({ type_id: 1 }, unique: true)
    index({ published: 1 }, unique: false)

    class << self
      def random
        skip(rand(count)).first
      end
    end
  end
end
