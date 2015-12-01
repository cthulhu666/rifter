require 'spec_helper'

RSpec.describe ShipModules::ShieldAmplifier do
  let :fit do
    ShipFitting.new(ship: Ship.kestrel, character: Character.new)
  end

  describe 'Thermal Dissipation Amplifier II' do
    it 'boosts resistance' do
      fit.fit_module 'Thermal Dissipation Amplifier II'
      fit.calculate_effects
      expect(fit.shield_resistances[:thermal]).to eq(0.5)
    end

    context 'with stacking penalty' do
      it 'boosts resistance' do
        2.times { fit.fit_module 'Thermal Dissipation Amplifier II' }
        fit.calculate_effects
        expect(fit.shield_resistances[:thermal]).to be_within(0.001).of(0.663)
      end
    end
  end
end
