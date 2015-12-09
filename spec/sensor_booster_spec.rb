require 'spec_helper'

RSpec.describe ShipModules::SensorBooster do
  context 'With Targeting Range Script' do
    let(:script) { Charge.find_by(name: 'Targeting Range Script') }
    let(:fitting) do
      f = double(:fitting)
      expect(f).to receive(:boost_attribute).with(:max_target_range, 60.0, stacking_penalty: true)
      f
    end

    let(:sebo) do
      fm = ShipFitting::FittedModule.new(power: :med)
      fm.ship_module = ShipModule.find_by(name: 'Sensor Booster II')
      fm.charge = script
      fm.setup
      fm.effect({}, fitting: fitting, fitted_module: fm)
      fm
    end

    it 'doubles targeting range bonus' do
      expect(sebo.max_target_range_bonus).to eq(60)
    end
    it 'negates scan resolution bonus' do
      expect(sebo.scan_resolution_bonus).to eq(0)
    end
  end
end
