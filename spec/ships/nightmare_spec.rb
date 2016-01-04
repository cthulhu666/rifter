require 'spec_helper'

RSpec.describe 'Nightmare' do
  let(:ship) { Ship.find_by(name: 'Nightmare') }
  let(:character) { Character.perfect_skills_character }
  let(:fit) { ShipFitting.new(ship: ship, character: character) }
  let(:charge) { Charge.find_by(name: 'Multifrequency L') }

  before do
    fit.fit_module('100MN Afterburner II')
    4.times { fit.fit_module('Mega Pulse Laser II').charge = charge }
    fit.calculate_effects
  end

  it { expect(fit.max_velocity(:afterburner)).to be_within(0.1).of(746.5) }
  it { expect(fit.turrets_dps.sum).to be_within(0.1).of(481.9) }
  it { expect(fit.turrets.first.tracking_speed).to be_within(0.0001).of(0.058) }
end
