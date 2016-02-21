# frozen_string_literal: true
module Rifter
  class DamageProfile
    def initialize(*splat)
      fail ArgumentError unless splat.size == DAMAGE_TYPES.size
      @profile = Vector[*normalize(splat)].freeze
    end

    def to_a
      @profile
    end

    def normalize(args)
      sum = args.compact.sum
      args.map { |v| v.to_f / sum }
    end

    private :normalize

    DEFAULT = DamageProfile.new(1, 1, 1, 1)
  end
end
