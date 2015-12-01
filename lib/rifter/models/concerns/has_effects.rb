module Rifter
  module HasEffects
    extend ActiveSupport::Concern

    def the_effects
      @the_effects ||= begin
        effects.map do |eff|
          begin
            "Rifter::Effects::#{Effect.sanitize_effect_name(eff).camelcase}".constantize.new(self)
          rescue
            nil
          end
        end.compact.freeze
      end
    end

    def effect(attrs, options)
      the_effects.each do |eff|
        eff.effect(attrs, options) if eff.respond_to?(:effect)
      end
    end
  end
end
