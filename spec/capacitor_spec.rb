require 'spec_helper'

RSpec.describe ShipFitting do

  describe '#capacitor_capacity' do

    before { fit.calculate_effects }

    subject { fit.capacitor_capacity.round }

    context 'perfect skills' do

      context 'no modules' do

        let(:fit) do
          ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
        end

        it { is_expected.to eq 413 }

      end

      context 'with capacitor battery' do

        let(:fit) do
          f = ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
          f.fit_module 'Micro Capacitor Battery II'
          f
        end

        it { is_expected.to eq 479 }

      end

      context 'with capacitor battery and power diagnostic system' do

        let(:fit) do
          f = ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
          f.fit_module 'Micro Capacitor Battery II'
          f.fit_module 'Power Diagnostic System II'
          f
        end

        it { is_expected.to eq 503 }

      end

      context 'with capacitor battery and two power diagnostic systems' do

        let(:fit) do
          f = ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
          f.fit_module 'Micro Capacitor Battery II'
          2.times { f.fit_module 'Power Diagnostic System II' }
          f
        end

        it { is_expected.to eq 528 }

      end

    end
  end

  describe '#cap_recharge' do
    before { fit.calculate_effects }

    subject { fit.cap_recharge }

    context 'perfect skills' do

      context 'no modules' do

        let(:fit) do
          ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
        end

        it { is_expected.to be_within(0.01).of 8.33 }

      end
    end
  end

end
