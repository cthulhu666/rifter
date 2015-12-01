module Rifter
  module Effects
    class StructureHPMultiply < Effect
      def effect(attrs, fitting: nil, fitted_module: nil)
        attrs.hull_capacity *= miscellaneous_attributes.structure_hp_multiplier
      end
    end
  end
end
