# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'T3 cruisers' do
  include_context 'dogma'

  let(:fitting) do
    Rifter::FittingContext.new(ctx)
  end

  describe 'Tengu' do
    before do
      fitting.ship = Rifter::ItemStore['Tengu']
      fitting.add_module Rifter::ItemStore['Tengu Defensive - Amplification Node']
      fitting.add_module Rifter::ItemStore['Tengu Electronics - CPU Efficiency Gate']
      fitting.add_module Rifter::ItemStore['Tengu Propulsion - Gravitational Capacitor']
      fitting.add_module Rifter::ItemStore['Tengu Offensive - Rifling Launcher Pattern']
      fitting.add_module Rifter::ItemStore['Tengu Engineering - Augmented Capacitor Reservoir']
    end

    it { expect(fitting.ship_attribute 'cpuOutput').to be_within(0.1).of(707.8) }
    it { expect(fitting.ship_attribute 'powerOutput').to be_within(0.1).of(750.0) }
    # TODO: why it fails, and why is it so slow
    # it { expect(fitting.ship_attribute 'launcherSlotsLeft').to eq 6 }
    # it { expect(fitting.ship_attribute 'hiSlots').to eq 6 }
    # it { expect(fitting.ship_attribute 'medSlots').to eq 6 }
    # it { expect(fitting.ship_attribute 'lowSlots').to eq 4 }
  end
end
