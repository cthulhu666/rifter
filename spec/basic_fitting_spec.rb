# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Basic fitting' do
  before { Dogma::Functions.dogma_init }
  let(:ctx) { Dogma.context }
  after { ctx.destroy! }

  let(:fitting) do
    Rifter::FittingContext.new(ctx)
  end

  context 'valid Rifter fit' do
    before do
      fitting.ship = Rifter::ItemStore.find 'Rifter'
      fitting.add_module Rifter::ItemStore.find 'Medium Shield Extender II'
    end

    it { expect(fitting.power_left).to eq 28.75 }
    it { expect(fitting.cpu_left).to eq 127.50 }
    it { expect(fitting.validate).to eq 0 }
  end

  context 'invalid Rifter fit' do
    before do
      fitting.ship = Rifter::ItemStore.find 'Rifter'
      3.times do
        fitting.add_module Rifter::ItemStore.find 'Medium Shield Extender II'
      end
    end

    it { expect(fitting.power_left).to eq(-16.25) }
    it { expect(fitting.cpu_left).to eq 57.5 }
    it { expect(fitting.validate).to be > 0 }
  end

  describe 'shields' do
    before do
      fitting.ship = Rifter::ItemStore['Rifter']
      fitting.add_module Rifter::ItemStore['Medium Shield Extender II']
      fitting.add_module Rifter::ItemStore['Damage Control II']
    end

    it { expect(fitting.ship_attribute 'shieldCapacity').to eq 1937.50 }
    it 'has correct shield resistances' do
      fitting.shield.resistances.zip([0.125, 0.30, 0.475, 0.5625]).each do |pair|
        expect(pair.first).to be_within(0.0001).of pair.last
      end
    end

    context 'with uniform damage profile' do
      let(:dmg_profile) { Rifter::DamageProfile::DEFAULT }
      it { expect(fitting.effective_hp(dmg_profile)).to be_within(0.1).of(5128.3) }
    end

    context 'with Blood Raiders damage profile' do
      let(:dmg_profile) { Rifter::DamageProfile.new(50, 48, 2, 0) }
      it { expect(fitting.effective_hp(dmg_profile)).to be_within(0.1).of(4820.8) }
    end
  end
end