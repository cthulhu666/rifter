module Rifter
  class Importer

    SLOT_EFFECT_NAMES = %w(loPower medPower hiPower rigSlot)

    attr_reader :db

    def initialize(file = 'sqlite-latest.sqlite')
      @db = Sequel.connect("sqlite://#{file}")
    end

    def ship_groups
      groups("Ship")
    end

    def module_groups
      groups("Module")
    end

    def charge_groups
      groups("Charge")
    end

    def groups(category)
      db[:invGroups].join(:invCategories, :categoryID => :categoryID).where(categoryName: category).select(:groupID, :groupName)
    end

    def items(group_id)
      db[:invTypes].where(groupID: group_id)
    end

    def determine_slot(type_id)
      rs = db[:dgmTypeEffects]
               .join(:dgmEffects, :effectID => :effectID)
               .where(typeID: type_id, effectName: SLOT_EFFECT_NAMES)
               .select(:effectName).first

      # TODO subsystems, rigs
      return nil unless rs.present?

      case rs[:effectName]
        when 'loPower'
          :lo
        when 'medPower'
          :med
        when 'hiPower'
          :hi
        when 'rigSlot'
          :rig
      end

    end

    def import
      truncate
      import_ships
      import_modules
      import_charges
      import_skills
      import_traits
      import_drones
    end

    def truncate
      ShipFittingDocument.delete_all
      Ship.delete_all
      ShipModule.delete_all
      Charge.delete_all
      Skill.delete_all
      Drone.delete_all
    end

    def import_skills
      groups("Skill").each do |group|
        items(group[:groupID]).each do |item|
          skill = Skill.new(
              name: item[:typeName],
              group: group[:groupName],
              type_id: item[:typeID],
              group_id: item[:groupID],
              effects: effects(item[:typeID]),
              published: item[:published].to_i == 1,
          )

          puts "#{skill.group} : #{skill.name}"

          skill.build_miscellaneous_attributes

          attributes(item[:typeID]).each do |row|
            attr_name = row[:attributeName].underscore
            attr_value = row[:valueInt] || row[:valueFloat]
            raise "AlreadySet" if skill.miscellaneous_attributes[attr_name].present?
            skill.miscellaneous_attributes[attr_name] = attr_value
          end

          skill.save!
        end
      end
    end

    def import_traits
      Ship.each do |ship|
        ship.traits.clear
        db[:invTraits].where(typeID: ship.type_id).each do |t|
          trait = ship.traits.build(bonus: t[:bonus], bonus_text: t[:bonusText])
          trait.skill = Skill.where(type_id: t[:skillID]).first

          ship.save!
        end
      end
    end

    def import_charges
      charge_groups.each do |group|
        items(group[:groupID]).each do |item|
          charge = Charge.new(
              name: item[:typeName],
              group: group[:groupName],
              type_id: item[:typeID],
              group_id: item[:groupID],
              effects: effects(item[:typeID]),
              mass: item[:mass],
              volume: item[:volume],
              capacity: item[:capacity],
              base_price: item[:basePrice],
              published: item[:published].to_i == 1,
          )

          puts "#{charge.group} : #{charge.name}"

          charge.build_miscellaneous_attributes

          attributes(item[:typeID]).each do |row|
            attr_name = row[:attributeName].underscore
            attr_value = row[:valueInt].try(:to_i) || row[:valueFloat]
            raise "AlreadySet" if charge.miscellaneous_attributes[attr_name].present?
            charge.miscellaneous_attributes[attr_name] = attr_value
          end

          charge.save!

        end
      end
    end

    def import_modules
      module_groups.each do |group|
        items(group[:groupID]).each do |item|

          ship_mod = module_class(group[:groupName]).new(
              name: item[:typeName],
              group: group[:groupName],
              slot: determine_slot(item[:typeID]),
              type_id: item[:typeID],
              group_id: item[:groupID],
              effects: effects(item[:typeID]),
              mass: item[:mass],
              volume: item[:volume],
              capacity: item[:capacity],
              base_price: item[:basePrice],
              published: item[:published].to_i == 1,
          )

          puts "#{ship_mod.group} : #{ship_mod.name}"

          ship_mod.build_miscellaneous_attributes

          attributes(item[:typeID]).each do |row|
            # {:categoryName=>"Structure", :attributeName=>"hp", :valueInt=>nil, :valueFloat=>1400.0}
            attr_name = row[:attributeName].underscore
            attr_value = row[:valueInt] || row[:valueFloat]
            raise "AlreadySet" if ship_mod.miscellaneous_attributes[attr_name].present?
            ship_mod.miscellaneous_attributes[attr_name] = attr_value
          end

          ship_mod.save!
        end
      end
    end

    def import_drones
      groups('Drone').each do |group|
        items(group[:groupID]).each do |item|
          drone = Drone.create(
              name: item[:typeName],
              group: group[:groupName],
              type_id: item[:typeID],
              effects: effects(item[:typeID]),
              mass: item[:mass],
              volume: item[:volume],
              capacity: item[:capacity],
              base_price: item[:basePrice],
              published: item[:published].to_i == 1,
          )
          drone.build_miscellaneous_attributes

          # TODO make a method out of this
          attributes(item[:typeID]).each do |row|
            # {:categoryName=>"Structure", :attributeName=>"hp", :valueInt=>nil, :valueFloat=>1400.0}
            category_name = row[:categoryName].delete(' ').underscore
            drone.miscellaneous_attributes[category_name] ||= Hash.new
            attr_name = row[:attributeName].underscore
            attr_value = row[:valueInt] || row[:valueFloat]

            drone.miscellaneous_attributes[category_name][attr_name] = attr_value
          end
          drone.save!
        end
      end
    end

    def import_ships
      ship_groups.each do |group|
        items(group[:groupID]).each do |item|

          ship = Ship.new(
              name: item[:typeName],
              group: group[:groupName],
              type_id: item[:typeID],
              mass: item[:mass],
              volume: item[:volume],
              capacity: item[:capacity],
              base_price: item[:basePrice],
              published: item[:published].to_i == 1,
          )

          puts "#{ship.group} : #{ship.name}"

          ship.build_miscellaneous_attributes

          attributes(item[:typeID]).each do |row|
            # {:categoryName=>"Structure", :attributeName=>"hp", :valueInt=>nil, :valueFloat=>1400.0}
            attr_name = row[:attributeName].underscore
            attr_value = row[:valueInt] || row[:valueFloat]
            raise "AlreadySet" if ship.miscellaneous_attributes[attr_name].present?
            ship.miscellaneous_attributes[attr_name] = attr_value
          end

          ship.save!
        end
      end
    end

    def module_class(group_name)
      "ShipModules::#{group_name.delete(' ')}".constantize rescue ShipModule
    end

    def attributes(type_id)
      db[:dgmTypeAttributes]
          .join(:dgmAttributeTypes, :attributeID => :attributeID)
          .join(:dgmAttributeCategories, :categoryID => :categoryID)
          .where(typeID: type_id)
          .select(:categoryName, :attributeName, :valueInt, :valueFloat)
          .all
    end

    def effects(type_id)
      db[:dgmTypeEffects]
          .join(:dgmEffects, :effectID => :effectID)
          .where(typeID: type_id)
          .select(:effectName)
          .map { |e| e[:effectName] }
    end

  end
end

#i = Importer.new(ENV['FILE'])
#i.import

#i.ship_groups.each do |g|
#  puts g
#  i.ships(g[:groupID]).select(:typeName).each { |ship| puts ship }
#end
