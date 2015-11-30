require 'spec_helper'

RSpec.describe 'Shield boosting' do

  context 'Hawk' do

    let :fit do
      f = ShipFitting.new(ship: Ship.find_by(name: 'Hawk'), character: Character.perfect_skills_character)
    end

    it 'has correct shield boost value' do
      pending

      fit.fit_module 'Medium Shield Booster II'
      fit.fit_module 'Damage Control II'
      fit.calculate_effects

      expect(fit.effective_shield_boost(damage_profile: ShipFitting::DEFAULT_DAMAGE_PROFILE)).to be_within(0.1).of(109)
    end

  end
end
