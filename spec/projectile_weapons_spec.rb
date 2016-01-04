require 'spec_helper'

RSpec.describe 'Projectile weapons' do
  context 'Gnosis' do
    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Gnosis'), character: character)
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'Hail M')
    end

    before do
      5.times { fit.fit_module 'Dual 180mm AutoCannon II' }
      fit.turrets.each { |t| t.charge = charge }
      fit.calculate_effects
    end

    it { expect(fit.turrets_dps.sum).to be_within(0.1).of(232.5) }
  end
  context 'Sleipnir' do
    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Sleipnir'), character: character)
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'Hail M')
    end

    describe 'stacking penalties' do
      before do
        5.times { fit.fit_module 'Dual 180mm AutoCannon II' }
        4.times { fit.fit_module 'Gyrostabilizer II' }
        fit.fit_module 'Medium Projectile Burst Aerator II'
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(780.7) }
    end

    describe 'optimal + falloff' do
      context 'Tracking Enhancer' do
        before do
          5.times { fit.fit_module 'Dual 180mm AutoCannon II' }
          fit.fit_module 'Tracking Enhancer II'
          fit.turrets.each { |t| t.charge = charge }
          fit.calculate_effects
        end
        it { expect(fit.turrets.first.optimal).to be_within(0.1).of(1320.0) }
        it { expect(fit.turrets.first.falloff).to be_within(0.1).of(14_512.5) }
      end

      context 'Tracking Computer' do
        before do
          5.times { fit.fit_module 'Dual 180mm AutoCannon II' }
          fit.fit_module('Tracking Computer II').charge = Charge.find_by(name: 'Optimal Range Script')
          fit.turrets.each { |t| t.charge = charge }
          fit.calculate_effects
        end
        it { expect(fit.turrets.first.optimal).to be_within(0.1).of(1380.0) }
        it { expect(fit.turrets.first.falloff).to be_within(0.1).of(15_721.9) }
      end
    end
  end

  context 'Tornado' do
    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Tornado'), character: character)
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'EMP L')
    end

    describe '#turrets_volley' do
      before do
        8.times { fit.fit_module('800mm Repeating Cannon II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.power_usage).to be_within(0.1).of(792.0) }
      it { expect(fit.cpu_usage).to eq(123) }
      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(1963.7) }
      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(461.8) }
      it { expect(fit.turrets.first.optimal).to be_within(0.1).of(3000) }
      it { expect(fit.turrets.first.falloff).to be_within(0.1).of(32_250) }
    end
  end

  context 'Autocannons fitted Rifter' do
    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Rifter'), character: character)
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'EMP S')
    end

    describe '#turrets_volley' do
      before do
        3.times { fit.fit_module('200mm AutoCannon II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(246.6) }

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(91.3) }
    end

    context 'With 1 gyrostab' do
      describe '#turrets_volley' do
        before do
          3.times { fit.fit_module('200mm AutoCannon II') }
          1.times { fit.fit_module('Gyrostabilizer II') }
          fit.turrets.each { |t| t.charge = charge }
          fit.calculate_effects
        end

        it { expect(fit.turrets_volley.sum).to be_within(0.1).of(271.2) }

        it { expect(fit.turrets_dps.sum).to be_within(0.1).of(112.2) }
      end
    end

    context 'With 2 gyrostabs' do
      describe '#turrets_volley' do
        before do
          3.times { fit.fit_module('200mm AutoCannon II') }
          2.times { fit.fit_module('Gyrostabilizer II') }
          fit.turrets.each { |t| t.charge = charge }
          fit.calculate_effects
        end

        it { expect(fit.turrets_volley.sum).to be_within(0.1).of(294.8) }

        it { expect(fit.turrets_dps.sum).to be_within(0.1).of(134.2) }
      end
    end
  end
end
