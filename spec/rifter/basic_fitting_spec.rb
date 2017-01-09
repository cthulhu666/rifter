# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Basic fitting' do
  include_context 'dogma'

  let(:fitting) do
    Rifter::FittingContext.new(ctx)
  end

  context 'valid Rifter fit' do
    before do
      fitting.ship = Rifter::ItemStore['Rifter']
      fitting.add_module Rifter::ItemStore['Medium Shield Extender II']
    end

    it { expect(fitting.power_left).to eq 28.75 }
    it { expect(fitting.cpu_left).to eq 127.50 }
  end

  describe 'shields' do
    before do
      fitting.ship = Rifter::ItemStore['Rifter']
      fitting.add_module Rifter::ItemStore['Medium Shield Extender II']
      fitting.add_module Rifter::ItemStore['Damage Control II']
    end

    it { expect(fitting.ship_attribute('shieldCapacity')).to eq 1937.50 }
    it 'has correct shield resistances' do
      fitting.shield.resistances.zip([0.125, 0.30, 0.475, 0.5625]).each do |pair|
        expect(pair.first).to be_within(0.0001).of pair.last
      end
    end

    context 'with uniform damage profile' do
      let(:dmg_profile) { Rifter::DamageProfile::DEFAULT }
      it { expect(fitting.effective_hp(dmg_profile)).to be_within(0.1).of(5122.9) }
    end

    context 'with Blood Raiders damage profile' do
      let(:dmg_profile) { Rifter::DamageProfile.new(50, 48, 2, 0) }
      it { expect(fitting.effective_hp(dmg_profile)).to be_within(0.1).of(4815.3) }
    end
  end
end
