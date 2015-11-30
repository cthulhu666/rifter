module Rifter
  class Trait

    class << self

      def description(desc = nil)
        @description ||= desc
      end

    end

    attr_reader :bonus

    def initialize(bonus:)
      @bonus = bonus
    end

  end
end
