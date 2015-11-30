require 'spec_helper'

RSpec.describe ShipModules::ShieldHardener, type: :model do

  let :fit do
    ShipFitting.new(ship: Ship.kestrel, character: Character.new)
  end

  describe "Adaptive Invulnerability Field II" do

    it "boosts resistances" do
      fit.fit_module "Adaptive Invulnerability Field II"
      fit.calculate_effects
      expect(fit.shield_resistances[:em].round(2)).to eq(0.30)
      expect(fit.shield_resistances[:thermal].round(2)).to eq(0.44)
      expect(fit.shield_resistances[:kinetic].round(2)).to eq(0.58)
      expect(fit.shield_resistances[:explosive].round(2)).to eq(0.65)
    end

    context "with stacking penalty" do
      it "boosts resistances" do
        2.times { fit.fit_module "Adaptive Invulnerability Field II" }
        fit.calculate_effects
        expect(fit.shield_resistances[:em].round(3)).to eq(0.483)
        expect(fit.shield_resistances[:thermal].round(3)).to eq(0.586)
        expect(fit.shield_resistances[:kinetic].round(3)).to eq(0.690)
        expect(fit.shield_resistances[:explosive].round(3)).to eq(0.741)
      end
    end


  end

end
