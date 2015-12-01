require 'spec_helper'

RSpec.describe 'Energy weapons' do
  context 'Abaddon' do
    let :fit do
      f = ShipFitting.new(ship: Ship.find_by(name: 'Abaddon'), character: character)
      8.times { f.fit_module('Mega Pulse Laser II').charge = charge }
      f
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'Multifrequency L')
    end

    before { fit.calculate_effects }

    it { expect(fit.turrets_volley.sum).to be_within(0.1).of(2732.4) }
    it { expect(fit.turrets_dps.sum).to be_within(0.1).of(481.9) }
  end

  context 'Imperial Navy Slicer' do
    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Imperial Navy Slicer'), character: character)
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'Multifrequency S')
    end

    describe 'turrets damage' do
      before do
        2.times { fit.fit_module('Small Focused Pulse Laser II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(307.4) }

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(122) }
    end

    context 'With Heat Sink' do
      before do
        2.times { fit.fit_module('Small Focused Pulse Laser II') }
        2.times { fit.fit_module('Heat Sink II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(367.5) }

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(179.3) }
    end

    context 'Harbinger' do
      let :fit do
        ShipFitting.new(ship: Ship.find_by(name: 'Harbinger'), character: character)
      end

      let :charge do
        Charge.find_by(name: 'Multifrequency M')
      end

      before do
        6.times { fit.fit_module('Focused Medium Pulse Laser II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(819.7) }

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(281.1) }
    end
  end
end
