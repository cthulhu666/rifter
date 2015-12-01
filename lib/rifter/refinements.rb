module Refinements

  refine Numeric do
    def to_rad
      self / 180.0 * Math::PI
    end
  end

end
