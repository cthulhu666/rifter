require 'spec_helper'

RSpec.describe ShipModule do
  describe '#validate_skills' do
    let(:dish_washing) { Skill.new(name: 'Dish washing') }

    let :ship_module do
      ShipModule.new do |m|
        m.required_skills << RequiredSkill.new(
          skill: dish_washing,
          level: 3
        )
      end
    end

    it do
      expect(
        ship_module.validate_skills('Binge drinking' => 4)
      ).to eq([[dish_washing, 3]])
    end

    it do
      expect(
        ship_module.validate_skills('Binge drinking' => 4, 'Dish washing' => 2)
      ).to eq([[dish_washing, 3]])
    end

    it do
      expect(
        ship_module.validate_skills('Binge drinking' => 4, 'Dish washing' => 3)
      ).to be_empty
    end
  end

  describe '#skill_required?' do
    let(:skill) { Skill.find_by(name: 'Rocket Specialization') }

    context 'for module that requires a skill' do
      let(:mod) { ShipModule.find_by(name: 'Rocket Launcher II') }
      it { expect(mod.skill_required?(skill)).to be(true) }
    end

    context 'for module that does not require a skill' do
      let(:mod) { ShipModule.find_by(name: 'Rocket Launcher I') }
      it { expect(mod.skill_required?(skill)).to be(false) }
    end
  end

  describe '#increase_meta_level' do
    %i(autocannon artillery).each do |weapon_type|
      context "Weapon type: #{weapon_type}" do
        let(:mod) { ShipModule.weapon_type(weapon_type).random }
        let(:better) { mod.increase_meta_level }

        it { expect(better.weapon_type).to eq(mod.weapon_type) }
        it { expect(better.meta_level).to be >= mod.meta_level }
      end
    end

    context 'Shield Extender' do
      let(:mod) { ShipModules::ShieldExtender.random }
      let(:better) { mod.increase_meta_level }

      it { expect(better).to be_a(ShipModules::ShieldExtender) }
      it { expect(better.meta_level).to be >= mod.meta_level }
    end
  end
end
