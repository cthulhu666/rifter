require 'spec_helper'

RSpec.describe 'Missiles' do
  context 'CN Hookbill' do
    let(:character) { Character.perfect_skills_character }
    let(:fit) do
      f = ShipFitting.new(ship: Ship.find_by(name: 'Caldari Navy Hookbill'), character: character)
      f.fit_module('Light Missile Launcher II').charge = Charge.find_by(name: 'Inferno Fury Light Missile')
      f.fit_module('Light Missile Launcher II').charge = Charge.find_by(name: 'Mjolnir Fury Light Missile')
      f.fit_module('Light Missile Launcher II').charge = Charge.find_by(name: 'Scourge Fury Light Missile')
      f
    end
    before { fit.calculate_effects }
    it 'Does more kinetic dmg than other types of damage' do
      dps_without_reloads = fit.missile_dps.first
      expect(dps_without_reloads[:thermal]).to be_within(0.1).of(36.2)
      expect(dps_without_reloads[:em]).to be_within(0.1).of(36.2)
      expect(dps_without_reloads[:kinetic]).to be_within(0.1).of(40.7)
    end
  end

  context 'Orthrus with RLML' do
    let(:character) { Character.perfect_skills_character }
    let(:charge) { Charge.find_by(name: 'Inferno Fury Light Missile') }
    let(:fit) do
      f = ShipFitting.new(ship: Ship.find_by(name: 'Orthrus'), character: character)
      6.times { f.fit_module('Rapid Light Missile Launcher II').charge = charge }
      f
    end
    before { fit.calculate_effects }
    it { expect(fit.launchers.first.range).to be_within(0.5).of(47_461) }
  end

  context 'Cerberus with Heavy Missiles' do
    let(:character) { Character.perfect_skills_character }
    let(:charge) { Charge.find_by(name: 'Inferno Precision Heavy Missile') }
    let(:fit) do
      f = ShipFitting.new(ship: Ship.find_by(name: 'Cerberus'), character: character)
      6.times { f.fit_module 'Heavy Missile Launcher II' }
      f.launchers.each { |l| l.charge = charge }
      f
    end
    before { fit.calculate_effects }
    it { expect(fit.launchers.first.range).to be_within(0.5).of(70_748) }
  end

  context 'Raven with Cruise Missiles' do
    let(:character) { Character.perfect_skills_character }
    let(:fit) { ShipFitting.new(ship: Ship.find_by(name: 'Raven'), character: character) }

    describe 'missile alpha and dps' do
      let(:charge) { Charge.find_by(name: 'Inferno Precision Cruise Missile') }
      before do
        6.times { fit.fit_module 'Cruise Missile Launcher II' }
        fit.launchers.each { |l| l.charge = charge }
        fit.calculate_effects
      end
      it { expect(fit.missile_alpha.sum).to be_within(0.1).of(3093.8) }
      # TODO: this changed from 362.2 to 347.17 after 8th dec 2015 release, take a closer look why
      it { expect(fit.missile_dps.last.sum).to be_within(0.1).of(347.2) }
    end
  end

  context 'RNI with Cruise Missiles' do
    let(:character) { Character.perfect_skills_character }
    let(:fit) { ShipFitting.new(ship: Ship.find_by(name: 'Raven Navy Issue'), character: character) }

    describe 'missile precision' do
      let(:charge) { Charge.find_by(name: 'Inferno Precision Cruise Missile') }
      before do
        6.times { fit.fit_module 'Cruise Missile Launcher II' }
        fit.launchers.each { |l| l.charge = charge }
        fit.calculate_effects
      end
      it { expect(fit.launchers.first.aoe_cloud_size).to eq(167.0625) }
    end
  end

  context 'RLML fitted Caracal' do
    let :fit do
      ShipFitting.new(ship: Ship.caracal, character: character)
    end

    let :character do
      Character.new
    end

    describe 'missile alpha and dps' do
      let(:charge) { Charge.find_by(name: 'Inferno Fury Light Missile') }

      before do
        2.times { fit.fit_module 'Rapid Light Missile Launcher II' }
        fit.launchers.each { |l| l.charge = charge }
        fit.calculate_effects
      end

      context 'with no skills' do
        it { expect(fit.missile_alpha.sum).to eq(232.0) }
        it { expect(fit.missile_dps.first.sum.to_i).to eq(37) }
        it { expect(fit.missile_dps.last.sum.to_i).to eq(29) }
      end

      context "with 'light missiles' and 'warhead upgrades' skills maxed out" do
        let :character do
          Character.new do |c|
            c.character_skills.build(skill: Skill.find_by(name: 'Light Missiles'), level: 5)
            c.character_skills.build(skill: Skill.find_by(name: 'Warhead Upgrades'), level: 5)
          end
        end

        it { expect(fit.missile_alpha.sum).to eq(319) }
        # TODO: it { expect(fit.missile_dps.first.sum.to_i).to eq(99) }
        # TODO it { expect(fit.missile_dps.last.sum.to_i).to eq(29) }
      end

      context 'With perfect skills' do
        let(:character) { Character.perfect_skills_character }
        it { expect(fit.launchers.first.range).to be_within(0.1).of(47_461) }
      end
    end

    context 'with Ballistic Control System' do
      let(:charge) { Charge.find_by(name: 'Inferno Fury Light Missile') }

      before do
        2.times { fit.fit_module(ShipModule['Rapid Light Missile Launcher II']) }
        2.times { fit.fit_module(ShipModule['Ballistic Control System II']) }
        2.times { fit.fit_module(ShipModule['Missile Guidance Enhancer II']) }
        2.times { fit.fit_module(ShipModule['Medium Warhead Calefaction Catalyst I']) }
        fit.launchers.each { |l| l.charge = charge }
        fit.calculate_effects
      end

      describe 'Missile alpha and dps' do
        context 'with no skills' do
          it { expect(fit.missile_alpha.sum).to be_within(0.1).of(301.5) }
          it { expect(fit.missile_dps.first.sum).to be_within(0.1).of(59.4) }
          it { expect(fit.missile_dps.last.sum).to be_within(0.1).of(44.2) }
          it { expect(fit.launchers.first.range).to be_within(0.1).of(17_491.5) }
        end

        context 'with perfect skills' do
          let :character do
            Character.perfect_skills_character
          end

          it { expect(fit.missile_alpha.sum).to be_within(0.1).of(414.6) }
          it { expect(fit.missile_dps.first.sum).to be_within(0.1).of(158.2) }
          it { expect(fit.missile_dps.last.sum).to be_within(0.1).of(94.85) }
          it { expect(fit.launchers.first.range).to be_within(0.1).of(59_033.8) }
        end
      end
    end
  end

  context 'T2 Rocket Launchers fitted Kestrel' do
    let :fit do
      ShipFitting.new(ship: Ship.kestrel, character: character)
    end

    let :character do
      Character.new
    end

    let(:charge) { Charge.find_by(name: 'Scourge Rage Rocket') }

    before do
      4.times { fit.fit_module(ShipModule['Rocket Launcher II']) }
      fit.launchers.each { |l| l.charge = charge }
      fit.fit_module 'Missile Guidance Computer II' # TODO: check range and stuff
      fit.calculate_effects
    end

    describe 'missile alpha and dps' do
      context 'with no skills' do
        it { expect(fit.missile_alpha.sum.to_i).to eq(178) }
        it { expect(fit.missile_dps.first.sum.to_i).to eq(44) }
        it { expect(fit.missile_dps.last.sum.to_i).to eq(42) }
      end

      context "with 'rockets', 'warhead upgrades' skills maxed out" do
        let :character do
          Character.new do |c|
            c.character_skills.build(skill: Skill.find_by(name: 'Rockets'), level: 5)
            c.character_skills.build(skill: Skill.find_by(name: 'Warhead Upgrades'), level: 5)
          end
        end

        it do
          expect(fit.missile_alpha.sum.to_i).to eq(245)
        end
        # TODO: it { expect(fit.missile_dps.first.sum.to_i).to eq(111) }
        # TODO it { expect(fit.missile_dps.last.sum.to_i).to eq(39) }
      end

      context 'with perfect skills' do
        let :character do
          Character.perfect_skills_character
        end

        it do
          expect(fit.missile_alpha.sum.to_i).to eq(306)
        end

        # TODO: it { expect(fit.missile_dps.first.sum.to_i).to eq(111) }
        # TODO it { expect(fit.missile_dps.last.sum.to_i).to eq(39) }
      end
    end
  end
end
