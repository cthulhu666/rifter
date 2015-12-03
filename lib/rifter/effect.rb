module Rifter
  class Effect
    attr_reader :mod

    delegate :miscellaneous_attributes, to: :mod

    class << self
      def description(desc = nil)
        @description ||= desc
      end

      def sanitize_effect_name(s)
        s = s.strip.delete(' ')
        s = s.gsub(/&(.)/, "And#{Regexp.last_match(1).upcase}") if s =~ /&(.)/
        s
      end

      def create(skill_or_module)
        case skill_or_module
        when ShipModule

        when Skill

        else
          fail 'ShipModule or Skill needed'
        end
      end
    end

    def initialize(mod)
      @mod = mod
    end

    # TODO: merge effect and skill_effects

    def inspect
      "#<#{self.class} module: #{mod}>"
    end

    def to_s
      "#<#{self.class}>"
    end
  end
end
