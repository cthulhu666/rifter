module Rifter
  class Skill
    include Mongoid::Document
    store_in collection: 'skills'

    include HasEffects

    RELEVANT_GROUPS = ['Drones', 'Electronic Systems', 'Navigation', 'Gunnery', 'Missiles', 'Spaceship Command', 'Rigging', 'Shields', 'Armor', 'Targeting', 'Engineering']

    field :name, type: String
    field :group, type: String
    field :published, type: Boolean

    # typeID in db dump
    field :type_id
    # groupID in db dump
    field :group_id

    field :effects, type: Array, default: []

    embeds_one :miscellaneous_attributes, class_name: 'Rifter::MiscellaneousAttributes'

    scope :group, ->(g) { where(group: g) }
    scope :relevant, -> { where(group: { '$in' => RELEVANT_GROUPS }) }
    scope :with_effect, -> (e) { where(:effects.in => [e]) }

    scope :published, -> { where(published: true) }
    default_scope -> { published }

    index({ type_id: 1 }, unique: true)
    index({ published: 1 }, unique: false)

    class << self
      def [](name)
        find_by(name: name)
      end

      def random
        skip(rand(count)).first
      end

      def relevant_effects
        Skill.all.inject([]) { |a, s| a << s.effects; a }.flatten.uniq
      end

      def init_effects_cache
        @effects = Hash.new do |h, key|
          h[key] = key.effects.map do |eff|
            klass = Effect.sanitize_effect_name(eff).camelcase
            begin
              Effects.const_get(klass)
            rescue
              :nil
            end
          end.compact.freeze
        end
      end

      attr_reader :effects
    end

    # TODO: synchronisation ?
    init_effects_cache

    def inspect
      "#<#{self.class} _id: #{id}, name: #{name}, group: #{group}>"
    end

    def to_s
      "#<#{self.class}: #{name}>"
    end
  end
end
