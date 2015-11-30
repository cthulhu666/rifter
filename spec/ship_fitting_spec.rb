require 'spec_helper'

RSpec.describe ShipFitting do

  describe '#validate_drone_skills' do
    let(:character) {
      ch = Character.new
      ch.character_skills.build(skill: Skill.find_by(name: 'Drones'), level: 3)
      ch
    }

    let(:fit) {
      f = ShipFitting.new(ship: Ship.find_by(name: 'Vexor'), character: character)
      5.times { f.fit_drone 'Acolyte II' }
      f
    }

    before { fit.calculate_effects }
    it { expect(fit.validate_drone_skills).to eq(2) }

  end

  describe '#propulsion_mods' do

    let(:fit) {
      f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
      f.fit_module '1MN Afterburner II'
      f
    }

    it { expect(fit.propulsion_mods.size).to eq(1) }
    it { expect(fit.propulsion_mods(:afterburner).size).to eq(1) }
    it { expect(fit.propulsion_mods(:microwarpdrive).size).to eq(0) }
    it { expect { fit.propulsion_mods(:foo) }.to raise_error(ArgumentError) }

  end

  describe '#max velocity' do
    context 'Kestrel with 1MN AB' do
      let(:fit) {
        f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
        f.fit_module '1MN Afterburner II'
        f
      }
      before { fit.calculate_effects }
      it { expect(fit.max_velocity(:afterburner)).to be_within(0.1).of(733.0) }
    end

    context 'Kestrel with 5MN MWD' do
      let(:fit) {
        f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
        f.fit_module '5MN Microwarpdrive II'
        f
      }
      before { fit.calculate_effects }
      it { expect(fit.max_velocity(:microwarpdrive)).to be_within(0.1).of(1866.4) }
    end

    context 'Kestrel with 1MN AB and Nano' do
      let(:fit) {
        f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
        f.fit_module '1MN Afterburner II'
        f.fit_module 'Nanofiber Internal Structure II'
        f
      }
      before { fit.calculate_effects }
      it { expect(fit.max_velocity).to be_within(0.1).of(355.9) }
      it { expect(fit.max_velocity(:afterburner)).to be_within(0.1).of(802.6) }
    end

    context 'Kestrel with 10MN AB' do
      let(:fit) {
        f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
        f.fit_module '10MN Afterburner II'
        f
      }
      before { fit.calculate_effects }
      it { expect(fit.max_velocity(:afterburner)).to be_within(0.1).of(1401.6) }
    end
  end

  describe '#shield_hp' do
    let(:fit) { ShipFitting.new(ship: Ship.caracal, character: Character.new) }

    before :each do
      fit.calculate_effects
    end

    it { expect(fit.shield_hp(damage_profile: {explosive: 100}).round).to eq(3400) }
    it { expect(fit.shield_hp(damage_profile: {kinetic: 50, explosive: 50}).round).to eq(3091) }
  end

  describe '#max_group_fitted' do
    let(:fit) do
      f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
      2.times { f.fit_module 'Small Ancillary Armor Repairer' }
      f
    end

    before :each do
      fit.calculate_effects
    end

    it { expect(fit.max_group_fitted).to be > 0 }
  end

  describe "Rig drawback" do

    ShipModule.where(
        :rig_size => 1,
        'miscellaneous_attributes.tech_level' => 2,
        'miscellaneous_attributes.drawback' => {:$exists => true}
    ).each do |rig|

      context "#{rig.name}" do

        let(:fit) { ShipFitting.new(ship: Ship.kestrel, character: character) }
        let(:mod) { fit.fitted_modules(klass: rig.class).first }

        before :each do
          fit.fit_module rig
          fit.calculate_effects
        end

        subject { mod.drawback }

        context "No skills" do
          let(:character) { Character.new }

          it "has full drawback" do
            is_expected.to eq(rig.drawback)
          end
        end

        context "Perfect skills" do
          let(:character) { Character.perfect_skills_character }

          it "has reduced drawback" do
            is_expected.to eq(rig.drawback * 0.5)
          end
        end

      end


    end

  end

  describe '#align_time and related' do
    before { fit.calculate_effects }
    context 'empty Kestrel' do
      let(:fit) { ShipFitting.new(ship: Ship.kestrel, character: Character.new) }
      it { expect(fit.align_time).to be_within(0.1).of(5.0) }
    end
    context 'Kestrel with AB' do
      let(:fit) {
        f = ShipFitting.new(ship: Ship.kestrel, character: Character.new)
        f.fit_module '1MN Afterburner II'
        f
      }
      it { expect(fit.align_time).to be_within(0.1).of(7.3) }
    end
    context 'Perfect skills, Kestrel with AB and some agility mods' do
      let(:fit) {
        f = ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
        f.fit_module '1MN Afterburner II'
        f.fit_module 'Small Polycarbon Engine Housing II'
        f.fit_module 'Nanofiber Internal Structure II'
        f
      }
      it { expect(fit.agility).to be_within(0.01).of(1.68) }
      it { expect(fit.align_time).to be_within(0.01).of(3.76) }
    end
  end

  describe '#target_painter_effect' do
    let(:fit) {
      f = ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
      f.fit_module 'Target Painter II'
      f
    }
    let(:target) { Hashie::Mash.new(signature_radius: 100, modifiers: []) }
    before {
      fit.calculate_effects
      class << target
        include Modifiers
      end
    }

    it 'full effect within optimal range' do
      fit.target_painter_effect(target: target, distance: 1000)
      expect(target.signature_radius).to eq(137.5)
    end

  end

  Ship.group(Ship::ENABLED_GROUPS).each do |ship|
    describe ship.name do

      let(:fit) { ShipFitting.new(ship: ship, character: Character.perfect_skills_character) }

      before { fit.calculate_effects }

      it { expect(fit.validate_constraints).to eq 0 }

    end
  end

end
