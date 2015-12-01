require 'spec_helper'

RSpec.describe ShipFitting do
  describe '#signature_radius' do
    context 'Muninn' do
      let(:character) { Character.perfect_skills_character }
      let(:fit) do
        f = ShipFitting.new(ship: Ship.find_by(name: 'Muninn'), character: character)
        f.fit_module '50MN Microwarpdrive II'
        f
      end
      before { fit.calculate_effects }

      it { expect(fit.signature_radius).to eq(437.5) }
    end
  end
end
