module Rifter
  class Charge
    include Mongoid::Document
    store_in collection: 'charges'

    include HasEffects

    field :name
    field :group
    field :tech_level, type: Integer
    field :charge_size, type: Integer

    field :mass, type: Float
    field :volume, type: Float
    field :capacity, type: Float
    field :base_price, type: Float
    field :published, type: Boolean
    # TODO include EveItem

    # typeID in db dump
    field :type_id, type: Integer
    # groupID in db dump
    field :group_id, type: Integer

    field :launcher_group, type: Integer

    field :effects, type: Array, default: []

    embeds_one :miscellaneous_attributes, class_name: 'Rifter::MiscellaneousAttributes'

    has_and_belongs_to_many :launchers, class_name: 'Rifter::ShipModule'

    scope :group, -> (name) { where(:group.in => [name].flatten) }
    scope :projectile, -> { group(["Projectile Ammo", "Advanced Artillery Ammo", "Advanced Autocannon Ammo"]) }
    scope :hybrid, -> { group(["Hybrid Charge", "Advanced Railgun Charge", "Advanced Blaster Charge"]) }

    delegate :explosion_delay, :max_velocity,
             to: :miscellaneous_attributes, allow_nil: true

    before_save do
      self.charge_size = miscellaneous_attributes.charge_size.to_i rescue nil
      self.tech_level = miscellaneous_attributes.tech_level.to_i rescue nil
      self.launcher_group = miscellaneous_attributes.launcher_group.to_i rescue nil
    end

    scope :charge_size, ->(size) { where(charge_size: size) }
    scope :tech_level, ->(lvl) { where(tech_level: lvl) }

    scope :published, -> { where(published: true) }
    default_scope -> { published }

    #indices
    index({type_id: 1}, unique: true)
    index({charge_size: 1}, unique: false)
    index({tech_level: 1}, unique: false)
    index({launcher_ids: 1})
    index({published: 1}, unique: false)

    class << self
      def random
        skip(rand(count)).first
      end

      def bind_to_launchers
        each do |charge|
          if charge.launcher_group
            q = ShipModule.where(group_id: charge.launcher_group)
            q = q.where(charge_size: charge.charge_size.to_i) if charge.charge_size
            q = q.tech_level(2) if charge.tech_level == 2
            q.each { |l| l.charges << charge if l.respond_to?(:charges) }
          end
        end
        # missiles need some special treatment
        ShipModule.where(effects: {'$in' => ['useMissiles']}).each do |mod|
          groups = mod.miscellaneous_attributes.attributes
                       .select { |k, v| k =~ /^charge_group/ }.inject([]) do |arr, e|
            arr << e.last
            arr
          end
          mod.charges << Charge.where(group_id: {'$in' => groups})
        end
      end
    end

    def damage
      dmg = Damage::DAMAGE_TYPES.map do |dmg_type|
        [dmg_type, miscellaneous_attributes["#{dmg_type}_damage"]]
      end
      Damage.new(dmg)
    end

    def uniform_damage
      Damage::DAMAGE_TYPES.inject(0) do |sum, dmg_type|
        sum += miscellaneous_attributes["#{dmg_type}_damage"]
        sum
      end
        # TODO np ammo do Core Probe Launcher I
    rescue
      0
    end

    def inspect
      "#<Charge _id: #{id}, name: #{name}, group: #{group}>"
    end

    def to_s
      "#<Charge: #{name}>"
    end

    def is_missile?
      (/(missile|rocket|torpedo)/i =~ group).present?
    end

  end
end
