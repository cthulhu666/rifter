require 'spec_helper'

RSpec.describe 'Engineering skills' do
  describe 'cpu_usage' do
    let :fit do
      f = ShipFitting.new(ship: Ship.kestrel, character: Character.perfect_skills_character)
      4.times { f.fit_module 'Rocket Launcher II' }
      f.launchers.each { |l| l.charge = l.ship_module.charges.first }
      f
    end

    before { fit.calculate_effects }

    it { expect(fit.cpu_usage).to eq(51) }
    it { expect(fit.power_usage).to eq(14.4) }
  end
end
