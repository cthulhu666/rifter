require 'spec_helper'

RSpec.describe Turret do

  describe '#chance_to_hit' do

    let(:turret) { ShipModule.find_by name: '220mm Vulcan AutoCannon II' }
    let(:mod) { ShipFitting::FittedModule.new(power: :hi) }
    let(:big_target) { double(:target, signature_radius: 500)}
    let(:small_target) { double(:target, signature_radius: 50)}

    before { turret.setup(mod) }

    it 'always hits big stationary target' do
      expect(mod.chance_to_hit(target: big_target, distance: 2000, angle: 90, velocity: 0)).to eq(1.0)
    end

    it 'barely scratches small fast target' do
      expect(mod.chance_to_hit(target: small_target, distance: 2000, angle: 90, velocity: 1000)).to be_within(0.01).of(0.0)
    end

  end

end
