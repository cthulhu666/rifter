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
        if s =~ /&(.)/
          s = s.gsub(/&(.)/, "And#{$1.upcase}")
        end
        s
      end

      def create(skill_or_module)
        case skill_or_module
          when ShipModule

          when Skill

          else
            raise "ShipModule or Skill needed"
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

    def stacking_penalty(value, context, key = "#{self.class}", &block)
      n = context["stacking:#{key}"] ||= 0
      adjusted_value = value * ShipModule::STACKING_PENALTY[n]
      # puts "Adjusted value: #{value} to #{adjusted_value} due to stacking penalty"
      yield adjusted_value
      context["stacking:#{key}"] += 1
    end

    # TODO moved to ShipFitting
    # deprecate :stacking_penalty

  end
end
