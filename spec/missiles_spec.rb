# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Rifter::FittingContext do
  let(:ctx) { Dogma.context }
  after { ctx.destroy! }

  let(:fitting) do
    Rifter::FittingContext.new(ctx)
  end

  describe '#turrets' do
    before do
      fitting.ship = Rifter::ItemStore.find 'Kestrel'
      fitting.add_module Rifter::ItemStore.find 'Medium Shield Extender II'
      fitting.add_module Rifter::ItemStore.find 'Damage Control II'
      4.times do
        fitting.add_module Rifter::ItemStore.find 'Rocket Launcher II'
      end
    end

    it { expect(fitting.launchers.size).to eq 4 }
  end

  describe 'dps and stuff...' do
    before do
      fitting.ship = Rifter::ItemStore.find 'Kestrel'
      4.times do
        fitting.add_module Rifter::ItemStore.find('Rocket Launcher II'),
                           charge: Rifter::ItemStore.find('Scourge Rocket'),
                           state: Dogma::STATE_ACTIVE
      end
    end

    context 'single launcher volley' do
      let(:launcher) { fitting.launchers.first }
      it { expect(Rifter::Launcher.volley(launcher).sum).to be_within(0.01).of(56.71) }
    end

    context 'all launchers volley' do
      it { expect(fitting.launchers_volley.sum).to be_within(0.01).of(226.87) }
    end

    context 'all launchers DPS' do
      it { expect(fitting.launchers_dps.sum).to be_within(0.01).of(82.38) }
    end
  end
end
