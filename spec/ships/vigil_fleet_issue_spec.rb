require 'spec_helper'

RSpec.describe 'Vigil Fleet Issue' do

  let(:ship) { Ship.find_by(name: 'Vigil Fleet Issue') }
  let(:character) { Character.perfect_skills_character }
  let(:fit) { ShipFitting.new(ship: ship, character: character) }

  before {
    fit.fit_module('Stasis Webifier II')
    fit.fit_module('Rocket Launcher II').charge = Charge.find_by(name: 'Nova Rocket')
    fit.fit_module('Rocket Launcher II').charge = Charge.find_by(name: 'Mjolnir Rocket')
    fit.calculate_effects
  }

  it { expect(fit.fitted_modules(klass: ShipModules::StasisWeb).first.max_range).to eq(15000) }
  it { expect(fit.missile_dps.first[:explosive]).to be_within(0.1).of(37.0) }
  it { expect(fit.missile_dps.first[:em]).to be_within(0.1).of(32.95) }

end
