# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Rifter::FittingContext do
  include_context 'dogma'

  let(:fitting) do
    Rifter::FittingContext.new(ctx)
  end

  describe '#turrets' do
    before do
      fitting.ship = Rifter::ItemStore.find 'Rifter'
      fitting.add_module Rifter::ItemStore.find 'Medium Shield Extender II'
      fitting.add_module Rifter::ItemStore.find 'Damage Control II'
      4.times do
        fitting.add_module Rifter::ItemStore.find '200mm AutoCannon II'
      end
    end

    it { expect(fitting.turrets.size).to eq 4 }
  end

  describe 'dps and stuff...' do
    before do
      fitting.ship = Rifter::ItemStore.find 'Rifter'
      3.times do
        fitting.add_module Rifter::ItemStore.find('200mm AutoCannon II'),
                           charge: Rifter::ItemStore.find('Phased Plasma S'),
                           state: Dogma::STATE_ACTIVE
      end
    end

    context 'single turret volley' do
      let(:turret) { fitting.turrets.first }
      it { expect(Rifter::Turret.volley(turret).sum).to be_within(0.01).of(82.18) }
    end

    context 'all turrets volley' do
      it { expect(fitting.turrets_volley.sum).to be_within(0.01).of(246.55) }
    end

    context 'all turrets DPS' do
      it { expect(fitting.turrets_dps.sum).to be_within(0.01).of(91.32) }
    end
  end
end
