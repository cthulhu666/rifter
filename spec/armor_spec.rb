require 'spec_helper'

RSpec.describe 'Armor' do

  describe '#armor_capacity' do

    context 'Gnosis' do

      let :character do
        Character.perfect_skills_character
      end
      let :gnosis do
        ShipFitting.new(ship: Ship.find_by(name: 'Gnosis'), character: character)
      end

      before { fit.calculate_effects }

      let(:fit) {
        gnosis.fit_module '1600mm Rolled Tungsten Compact Plates'
        gnosis.fit_module '800mm Steel Plates II'
        gnosis
      }

      it { expect(fit.armor_capacity).to eq(13000) }

    end
  end


  describe '#armor_resistances' do

    context 'Astero' do

      let :character do
        Character.perfect_skills_character
      end
      let :astero do
        ShipFitting.new(ship: Ship.find_by(name: 'Astero'), character: character)
      end

      before { fit.calculate_effects }

      context 'Naked' do
        let(:fit) { astero }
        it { expect(fit.armor_resistances).to eq({em: 0.6, thermal: 0.48, kinetic: 0.48, explosive: 0.28}) }
      end

      context 'With Energized Adaptive Nano Membrane II' do
        let(:fit) {
          astero.fit_module 'Energized Adaptive Nano Membrane II'
          astero
        }
        it { expect(fit.armor_resistances).to eq({em: 0.7, thermal: 0.61, kinetic: 0.61, explosive: 0.46}) }
      end

      context 'With 2x Energized Adaptive Nano Membrane II' do
        let(:fit) {
          2.times { astero.fit_module 'Energized Adaptive Nano Membrane II' }
          astero
        }
        it { expect(fit.armor_resistances).to eq({em: 0.765, thermal: 0.695, kinetic: 0.695, explosive: 0.577}) }
      end

    end

  end

end
