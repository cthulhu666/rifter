require 'spec_helper'

RSpec.describe 'Shield recharge' do

  let(:ship) { Ship.find_by(name: 'Gnosis') }
  let(:character) { Character.perfect_skills_character }

  context 'Shield Flux Coil' do

    let(:fit) do
      f = Rifter::ShipFitting.new(ship: ship, character: character)
      3.times { f.fit_module 'Large Shield Extender II' }
      3.times { f.fit_module 'Shield Flux Coil II' }
      f
    end

    before { fit.calculate_effects }

    it { expect(fit.shield_capacity.round).to eq(9116) }
    it { expect(fit.shield_tank(damage_profile: ShipFitting::DEFAULT_DAMAGE_PROFILE)).to be_within(0.1).of(48.9) }
  end

  context 'Shield Power Relay' do
    let(:fit) do
      f = ShipFitting.new(ship: ship, character: character)
      3.times { f.fit_module 'Large Shield Extender II' }
      3.times { f.fit_module 'Shield Power Relay II' }
      f
    end

    before { fit.calculate_effects }

    it { expect(fit.shield_capacity.round).to eq(14844) }
    it { expect(fit.shield_tank(damage_profile: ShipFitting::DEFAULT_DAMAGE_PROFILE)).to be_within(0.1).of(62.2) }
  end

end
