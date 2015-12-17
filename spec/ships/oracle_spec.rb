require 'spec_helper'

RSpec.describe 'Oracle' do
  let(:ship) { Ship.find_by(name: 'Oracle') }
  let(:character) { Character.perfect_skills_character }
  let(:fit) { ShipFitting.new(ship: ship, character: character) }
  let(:charge) { Charge.find_by(name: 'Multifrequency L') }

  before do
    8.times { fit.fit_module('Mega Pulse Laser II').charge = charge }
    fit.calculate_effects
  end

  it { expect(fit.turrets_dps.sum).to be_within(0.1).of(481.9) }
  it { expect(fit.power_usage).to be_within(0.1).of(990.0) }
  it { expect(fit.cpu_usage).to be_within(0.1).of(159.0) }
end
