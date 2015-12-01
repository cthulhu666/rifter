module Rifter
  module Effects
    class AddToSignatureRadius2 < Effect
      def effect(attrs, _opts = {})
        attrs.signature_radius += miscellaneous_attributes.signature_radius_add
      end
    end
  end
end
