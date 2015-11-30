require 'spec_helper'

RSpec.describe Damage do

  describe '#calculate_turret_damage' do
    let(:damage) { Damage.new(kinetic: 100) }
    let(:turret) {
      double(:turret, chance_to_hit: 0.5)
    }
    let(:target) { double(:target, signature_radius: 500.0) }

    it { expect(
        damage.calculate_turret_damage(turret: turret, target: target, distance: 1000, angle: 90, velocity: 0).sum
    ).to be_within(0.1).of(40) }

  end

  describe '#calculate_missile_damage' do
    let(:damage) { Damage.new(kinetic: 100) }

    context 'Cruise Missile' do
      let(:launcher) { double(:launcher,
                              aoe_velocity: 69.0,
                              aoe_cloud_size: 330.0,
                              aoe_damage_reduction_factor: 4.5,
                              aoe_damage_reduction_sensitivity: 5.5)
      }

      context 'launched on No-skills Drake Battlecruiser' do
        let(:target) { double(:target, max_velocity: 150, signature_radius: 295.0) }
        it { expect(damage.calculate_missile_damage(launcher: launcher, target: target).sum).to be_within(0.1).of(45.66) }
      end

      context 'launched on slowboating All-V Caracal cruiser' do
        let(:target) { double(:target, max_velocity: 288, signature_radius: 125.0) }
        it { expect(damage.calculate_missile_damage(launcher: launcher, target: target).sum).to be_within(0.1).of(12.0) }
      end

      context 'launched on AB All-V Caracal cruiser' do
        let(:target) { double(:target, max_velocity: 718, signature_radius: 125.0) }
        it { expect(damage.calculate_missile_damage(launcher: launcher, target: target).sum).to be_within(0.1).of(5.3) }
      end

      context 'launched on MWD All-V Caracal cruiser' do
        let(:target) { double(:target, max_velocity: 1913, signature_radius: 750.0) }
        it { expect(damage.calculate_missile_damage(launcher: launcher, target: target).sum).to be_within(0.1).of(11.0) }
      end

    end
  end


end
