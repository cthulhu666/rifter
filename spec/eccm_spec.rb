require 'spec_helper'

RSpec.describe 'ECCM' do
  let(:character) { Character.new }
  let(:ship) { Ship.kestrel }
  let(:fit) { ShipFitting.new(ship: ship, character: character) }

  describe 'ship scanner strentgh' do
    it do
      expect(ship.scan_strength).to eq(
        gravimetric: 11.0, ladar: 0.0, radar: 0.0, magnetometric: 0.0)
    end
  end

  describe 'ECCM module' do
    before do
      fit.fit_module 'ECCM - Gravimetric I'
      fit.calculate_effects
    end

    it { expect(fit.scan_strength).to eq(19.8) }
  end
end
