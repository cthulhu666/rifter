module Rifter
  class ShipModule
    IRRELEVANT_GROUPS = ['Cargo Scanner', 'Ship Scanner', 'Survey Scanner', 'QA Module', 'Entosis Link', 'Missile Launcher Bomb', 'Countermeasure Launcher']

    DAMAGE_TYPES = Damage::DAMAGE_TYPES # for backward compatibility

    include Mongoid::Document
    include Mongoid::Attributes::Dynamic # TODO: remove?
    store_in collection: 'ship_modules'

    include MarketData
    include RequiresSkills
    include HasEffects

    field :name, type: String
    field :group, type: String
    field :slot, type: String

    field :relevant, type: Boolean, default: true

    field :mass, type: Float
    field :volume, type: Float
    field :capacity, type: Float
    field :base_price, type: Float
    field :published, type: Boolean
    # TODO: include EveItem

    # typeID in db dump
    field :type_id
    # groupID in db dump
    field :group_id
    # parentTypeID in invMetaTypes table
    field :parent_type_id, type: Integer
    # :metaGroupID in invMetaTypes table
    field :meta_group_id, type: Integer

    field :effects, type: Array, default: []

    field :faction, type: Boolean, default: false
    field :deadspace, type: Boolean, default: false

    scope :faction, -> { where(faction: true) }
    scope :deadspace, -> { where(deadspace: true) }

    scope :max_pg, ->(v) { self.or ['miscellaneous_attributes.power' => { :$lte => v }], ['miscellaneous_attributes.power' => nil] }
    scope :max_cpu, ->(v) { self.or ['miscellaneous_attributes.cpu' => { :$lte => v }], ['miscellaneous_attributes.cpu' => nil] }

    scope :published, -> { where(published: true) }
    default_scope -> { published }

    scope :relevant, -> { where(relevant: true) }
    scope :group, ->(name) { where(group: name) }
    scope :power, ->(slot) { where(slot: slot) }
    scope :meta_level, ->(l) { where('miscellaneous_attributes.meta_level' => l) }
    scope :tech_level, ->(l) { where('miscellaneous_attributes.tech_level' => l) }
    scope :with_price, -> { where(:avg_sell_price.gt => 0) }
    scope :weapons, -> { where(:weapon_type.exists => true) }
    scope :weapon_type, ->(t) { where(weapon_type: t) }

    # this fetches all mods but excludes all weapons other than given type
    scope :allow_weapon_type, ->(t) { where(:weapon_type.nin => weapon_types - [t].flatten.map(&:to_s)) }

    scope :with_effect, ->(e) { where(:effects.in => [e]) }
    scope :without_effect, ->(e) { where(:effects.nin => [e]) }

    embeds_one :miscellaneous_attributes, class_name: 'Rifter::MiscellaneousAttributes'
    has_and_belongs_to_many :variations, class_name: 'Rifter::ShipModule'

    # indices
    index({ slot: 1 }, unique: false)
    index({ type_id: 1 }, unique: true)
    index({ relevant: 1 }, unique: false)
    index({ published: 1 }, unique: false)
    index({ 'miscellaneous_attributes.meta_level' => 1 }, unique: false)

    class << self
      def [](name)
        find_by(name: name)
      end

      def random
        skip(rand(count)).first
      end

      def relevant_effects
        ShipModule.all.inject([]) { |a, s| a << s.effects; a }.flatten.uniq
      end

      def mark_relevant_modules
        ShipModule.each do |mod|
          mod.update_attribute(:relevant, !mod.group.in?(IRRELEVANT_GROUPS) && !(mod.name =~ /^capital/i))
        end
      end

      def setup_weapons
        each do |mod|
          if mod.fields['weapon_type'].present?
            mod.update_attribute :weapon_type, mod.infer_weapon_type
          end
        end
      end

      FACTION_PREFIXES = ['Ammatar Navy', 'Caldari Navy', 'Dark Blood ', 'Domination', 'Dread Guristas', 'Federation Navy', 'Imperial Navy', 'Khanid Navy', 'Republic Fleet', 'Shadow Serpentis', 'Sisters', 'Syndicate', 'Thukker', 'True Sansha']

      def mark_faction_modules
        meta_level(6..9).each do |mod|
          if FACTION_PREFIXES.any? { |prefix| mod.name.starts_with?(prefix) }
            mod.update_attribute :faction, true
          end
        end
      end

      def mark_deadspace_modules
        meta_level(10..20).each do |mod|
          if mod.name =~ /^(Gist|Corp|Pith|Cent|Core)/
            mod.update_attribute :deadspace, true
          end
        end
      end

      def setup_variations
        ShipModule.where(parent_type_id: nil).each do |m|
          m.variations = ShipModule.where(parent_type_id: m.type_id)
          m.variations.each do |v|
            v.variation_ids = m.variations.map(&:id) + [m.id] - [v.id]
            v.save!
          end
        end
      end

      def setup_ship_modules
        mark_relevant_modules
        setup_weapons
        assign_required_skills
        mark_faction_modules
        mark_deadspace_modules
        setup_variations
      end

      def fix_types
        where(_type: ShipModule.name).each do |m|
          klass = ShipModules.const_get(m.group.delete(' '))
          m.update_attribute(:_type, klass.name) unless klass.nil?
        end
      end

      def copy_attributes(*attrs)
        @attributes_to_copy = attrs
      end

      attr_reader :attributes_to_copy

      def weapon_types
        @weapon_types ||= distinct(:weapon_type).compact
      end
    end

    def power
      miscellaneous_attributes.try(:power) || 0
    end

    def cpu
      miscellaneous_attributes.try(:cpu) || 0
    end

    def cpu=(n)
      miscellaneous_attributes.cpu = n
    end

    def tech_level
      miscellaneous_attributes.tech_level.to_i
    end

    def meta_level
      miscellaneous_attributes.meta_level.to_i
    end

    def is_turret?
      Turret.in? self.class.included_modules
    end

    def is_launcher?
      Launcher.in? self.class.included_modules
    end

    def inspect
      "#<#{self.class} _id: #{id}, name: #{name}, meta_level: #{meta_level}>"
    end

    def to_s
      "#<#{self.class}: #{name}>"
    end

    def setup(fitted_module)
      atc = self.class.attributes_to_copy
      atc.each do |s|
        fitted_module[s] = miscellaneous_attributes[s]
      end unless atc.nil?
    end
  end
end
