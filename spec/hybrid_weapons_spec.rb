require 'spec_helper'

RSpec.describe "Hybrid weapons" do

  context "Blasters fitted Harpy" do

    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Harpy'), character: character)
    end

    let :character do
      Character.perfect_skills_character
    end

    let :charge do
      Charge.find_by(name: 'Antimatter Charge S')
    end

    describe 'turrets damage' do
      before do
        4.times { fit.fit_module('Light Neutron Blaster II') }
        fit.turrets.each { |t| t.charge = charge }
        fit.calculate_effects
      end

      it { expect(fit.turrets_volley.sum).to be_within(0.1).of(418.4) }

      it { expect(fit.turrets_dps.sum).to be_within(0.1).of(166) }

    end

  end
end
