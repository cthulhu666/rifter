require 'spec_helper'

RSpec.describe 'Naga' do
  let(:ship) { Ship.find_by(name: 'Naga') }
  let(:character) { Character.perfect_skills_character }
  let(:fit) { ShipFitting.new(ship: ship, character: character) }
  let(:charge) { Charge.find_by(name: 'Lead Charge L') }

  before do
    8.times { fit.fit_module('425mm Railgun II').charge = charge }
    fit.calculate_effects
  end

  it { expect(fit.turrets_dps.sum).to be_within(0.1).of(266.8) }
  it { expect(fit.power_usage).to be_within(0.1).of(831.6) }
  it { expect(fit.cpu_usage).to be_within(0.1).of(222.0) }
end
