# frozen_string_literal: true
require 'singleton'

module Rifter
  class Skills
    include Singleton

    def initialize
      @cache = Hash.new do |h, k|
        h[k] = ItemStore.where(categoryName: 'Skill', typeName: k).first
      end
    end

    def self.[](name)
      instance.find_by_name(name)
    end

    def find_by_name(name)
      @cache[name]
    end
  end
end
