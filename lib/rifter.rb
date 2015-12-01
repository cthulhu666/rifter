require 'hashie'
require 'active_support/all'
require 'mongoid'

require "rifter/version"
require "rifter/damage"
require "rifter/damage_profile"
require "rifter/modifiers"

Dir[File.dirname(__FILE__) + '/rifter/models/concerns/*.rb'].each { |file| require file }

require "rifter/models/ship"
require "rifter/models/ship_module"
require "rifter/models/character"
require "rifter/models/skill"
require "rifter/models/drone"
require "rifter/models/required_skill"
require "rifter/models/miscellaneous_attributes"
require "rifter/models/charge"

require "rifter/effect"
require "rifter/trait"
require "rifter/ship_fitting"

module Rifter

  module ShipModules
    Dir[File.dirname(__FILE__) + '/rifter/models/ship_modules/*.rb'].each do |file|
      base_name = File.basename(file).split('.').first
      # some classes violate the naming conventions (e.g. MissileDMGBonus) so we can't rely on base_name.camelcase
      klass_name = /class\s(.*?)\s/.match(File.read(file))[1]
      autoload klass_name, "rifter/models/ship_modules/#{base_name}"
    end
  end

  module Effects
    Dir[File.dirname(__FILE__) + '/rifter/effects/*.rb'].each do |file|
      base_name = File.basename(file).split('.').first
      # some classes violate the naming conventions (e.g. MissileDMGBonus) so we can't rely on base_name.camelcase
      klass_name = /class\s(.*?)\s/.match(File.read(file))[1]
      autoload klass_name, "rifter/effects/#{base_name}"
    end
  end

  module Traits
    Dir[File.dirname(__FILE__) + '/rifter/traits/*.rb'].each do |file|
      base_name = File.basename(file).split('.').first
      klass_name = base_name.camelcase
      autoload klass_name, "rifter/traits/#{base_name}"
    end
  end

end

require "rifter/missile_damage_bonus"
