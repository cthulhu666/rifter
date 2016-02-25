# frozen_string_literal: true
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/object/inclusion'

require 'sequel'
require 'ice_nine'

require 'dogma'

require 'rifter/version'
require 'rifter/attribute_value'
require 'rifter/item'
require 'rifter/item_store'
require 'rifter/fitting_context'
require 'rifter/attributes'
require 'rifter/skills'
require 'rifter/damage_profile'

module Rifter
  DB = Sequel.connect('sqlite://sqlite-latest.sqlite')
end
