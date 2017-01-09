# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Rifter::DefaultFittingValidator do
  include_context 'dogma'

  let(:fitting) do
    Rifter::FittingContext.new(ctx)
  end

  let(:validation) do
    validator.call(fitting)
  end

  let(:validator) do
    described_class.new
  end

  context 'valid Rifter fit' do
    before do
      fitting.ship = Rifter::ItemStore['Rifter']
      fitting.add_module Rifter::ItemStore['Medium Shield Extender II']
    end

    it { expect(validation).to be_success }
  end

  context 'invalid fit' do
    context 'power shortage' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        3.times do
          fitting.add_module Rifter::ItemStore.find 'Medium Shield Extender II'
        end
      end

      it { expect(validation.value.power).to eq(-16.25) }
      it { expect(validation.value.cpu).to eq 0 }
      it { expect(validation).to be_failure }
    end

    context 'high slots shortage' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        5.times do
          fitting.add_module Rifter::ItemStore.find '200mm AutoCannon II'
        end
      end

      it { expect(validation.value.turrets).to eq(-2) }
      it { expect(validation).to be_failure }
    end

    context 'calibration shortage' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        3.times do
          fitting.add_module Rifter::ItemStore['Small Drone Control Range Augmentor II']
        end
      end
      it { expect(validation).to be_failure }
    end

    context 'used more lo slots than available' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        4.times do
          fitting.add_module Rifter::ItemStore['Power Diagnostic System II']
        end
      end
      it { expect(validation).to be_failure }
      it { expect(validation.value.lo_slots).to eq(-1) }
    end

    context 'used more med slots than available' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        4.times do
          fitting.add_module Rifter::ItemStore['Small Shield Extender II']
        end
      end
      it { expect(validation).to be_failure }
      it { expect(validation.value.med_slots).to eq(-1) }
    end

    context 'used more hi slots than available' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        5.times do
          fitting.add_module Rifter::ItemStore['200mm AutoCannon II']
        end
      end
      it { expect(validation).to be_failure }
      it { expect(validation.value.hi_slots).to eq(-1) }
    end

    context 'used more rig slots than available' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        5.times do
          fitting.add_module Rifter::ItemStore['Small Drone Control Range Augmentor II']
        end
      end
      it { expect(validation).to be_failure }
      it { expect(validation.value.rig_slots).to eq(-2) }
    end

    xcontext 'max group fitted' do
      before do
        fitting.ship = Rifter::ItemStore.find 'Rifter'
        3.times do
          fitting.add_module Rifter::ItemStore.find 'Damage Control II'
        end
      end
      it { expect(validation.value.max_group_fitted).to eq(-2) }
      it { expect(validation).to be_failure }
    end
  end

end
