require 'spec_helper'

RSpec.describe 'Character skills' do
  # let :character do
  #  Character.new do |c|
  #    c.character_skills.build(skill: Skill.find_by(name: 'Caldari Cruiser'), level: 5)
  #    c.character_skills.build(skill: Skill.find_by(name: 'Power Grid Management'), level: 5)
  #    c.character_skills.build(skill: Skill.find_by(name: 'Weapon Upgrades'), level: 5)
  #    c.character_skills.build(skill: Skill.find_by(name: 'Launcher Rigging'), level: 5)
  #  end
  # end

  let(:fit) { ShipFitting.new(ship: Ship.caracal, character: character) }

  describe 'Caldari cruiser skill boosts rate of fire on Caracal' do
    let :character do
      Character.new do |c|
        c.character_skills.build(skill: Skill.find_by(name: 'Caldari Cruiser'), level: 5)
      end
    end

    before :each do
      2.times { fit.fit_module 'Rapid Light Missile Launcher II' }
      fit.launchers.each { |l| l.charge = Charge.find_by(name: 'Scourge Light Missile') }
      fit.calculate_effects
    end

    it do
      fit.launchers.each do |launcher|
        expect(launcher.speed).to eq(4680.0)
      end
    end
  end

  describe '#power_output' do
    let :character do
      Character.new do |c|
        c.character_skills.build(skill: Skill.find_by(name: 'Power Grid Management'), level: 5)
      end
    end

    before(:each) { fit.calculate_effects }

    it { expect(fit.power_output).to eq(787.5) }
  end

  describe 'Hull Upgrades' do
    let :character do
      Character.new do |c|
        c.character_skills.build(skill: Skill.find_by(name: 'Hull Upgrades'), level: 5)
      end
    end

    before(:each) { fit.calculate_effects }

    it { expect(fit.armor_capacity).to eq(1500) }
  end

  describe 'Mechanics' do
    let :character do
      Character.new do |c|
        c.character_skills.build(skill: Skill.find_by(name: 'Mechanics'), level: 5)
      end
    end

    before(:each) { fit.calculate_effects }

    it { expect(fit.hull_capacity).to eq(1750) }
  end
end
