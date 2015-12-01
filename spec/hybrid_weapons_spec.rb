require 'spec_helper'

RSpec.describe 'Hybrid weapons' do
  let :character do
    Character.perfect_skills_character
  end

  context 'Blasters fitted Megathron' do
    let :fit do
      f = ShipFitting.new(ship: Ship.find_by(name: 'Megathron'), character: character)
      7.times { f.fit_module('Neutron Blaster Cannon II').charge = charge }
      f
    end

    let :charge do
      Charge.find_by(name: 'Void L')
    end

    before { fit.calculate_effects }

    it { expect(fit.turrets_volley.sum).to be_within(0.1).of(3006.9) }
    it { expect(fit.turrets_dps.sum).to be_within(0.1).of(707.1) }
    it { expect(fit.turrets.first.optimal).to be_within(0.1).of(6750.0) }
    it { expect(fit.turrets.first.falloff).to be_within(0.1).of(6250.0) }
    it { expect(fit.turrets.first.tracking_speed).to be_within(0.001).of(0.067) }
  end

  context 'Blasters fitted Harpy' do
    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Harpy'), character: character)
    end

    let :charge do
      Charge.find_by(name: 'Antimatter Charge S')
    end

    describe 'turrets damage' do
      before do
        4.times { fit.fit_module('Light Neutron Blaster II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(418.4) }

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(166) }
    end
  end
end
