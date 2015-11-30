require 'spec_helper'

RSpec.describe "Drones" do

  let :character do
    Character.perfect_skills_character
  end

  context 'Worm' do

    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Worm'), character: character)
    end
    context 'No damage mods' do

      before do
        2.times { fit.fit_drone Drone.find_by(name: 'Hobgoblin II') }
        fit.calculate_effects
      end
      it { expect(fit.drone_dps.sum).to be_within(0.1).of(158.4) }

    end


  end

  context 'Vexor' do

    let :fit do
      ShipFitting.new(ship: Ship.find_by(name: 'Vexor'), character: character)
    end

    context 'No damage mods' do

      before do
        5.times { fit.fit_drone Drone.find_by(name: 'Hammerhead II') }
        fit.calculate_effects
      end
      it { expect(fit.drone_dps.sum).to be_within(0.1).of(237.6) }

    end

    context 'With 2 DDAs' do

      before do
        5.times { fit.fit_drone Drone.find_by(name: 'Hammerhead II') }
        2.times { fit.fit_module 'Drone Damage Amplifier II' }
        fit.calculate_effects
      end
      it { expect(fit.drone_dps.sum).to be_within(0.1).of(337.3) }

    end
  end
end
