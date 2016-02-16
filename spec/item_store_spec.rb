# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Rifter::ItemStore do
  let(:store) { described_class }

  describe '#find' do
    it { expect(store.find(587)).to be_truthy }
  end
end
