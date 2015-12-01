module Rifter
  class DamageProfile
    def initialize(h)
      h = h.symbolize_keys unless h.is_a?(DamageProfile)
      args = Damage::DAMAGE_TYPES.inject([]) { |a, e| a << h[e] }
      @profile = [Damage::DAMAGE_TYPES, normalize(args)].transpose.to_h
    end

    def [](k)
      @profile[k.to_sym]
    end

    def to_a
      @profile.to_a
    end

    def to_h
      @profile.dup
    end

    def normalize(args)
      sum = args.compact.sum
      args.map { |v| v.to_f / sum }
    end

    private :normalize
  end
end
