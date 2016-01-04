require 'spec_helper'

RSpec.describe 'Coercer' do
  let(:ship) { Ship.find_by(name: 'Coercer') }
  let(:character) { Character.perfect_skills_character }
  let(:fit) { ShipFitting.new(ship: ship, character: character) }
  let(:charge) { Charge.find_by(name: 'Multifrequency S') }
  let(:turret) { fit.turrets.first }

  before do
    8.times { fit.fit_module('Small Focused Pulse Laser II').charge = charge }
    fit.fit_module 'Small Energy Burst Aerator I'
    fit.calculate_effects
  end

  it { expect(fit.turrets_dps.sum).to be_within(0.1).of(241.0) }
  it { expect(fit.turrets_volley.sum).to be_within(0.1).of(546.5) }

  it { expect(fit.power_usage).to be_within(0.1).of(83.2) }
  it { expect(fit.cpu_usage).to be_within(0.1).of(96.0) }

  it { expect(turret.tracking_speed).to be_within(0.001).of(0.462) }
  # TODO: check with EFT it { expect(turret.optimal).to be_within(0.1).of(5906) }
  it { expect(turret.falloff).to be_within(0.1).of(3125) }
end
