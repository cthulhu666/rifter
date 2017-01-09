module Rifter
  class DefaultFittingValidator
    def call(f)
      status = OpenStruct.new
      status.power = [f.power_left, 0].min
      status.cpu = [f.cpu_left, 0].min
      status.turrets = [f.ship_attribute('turretSlotsLeft'), 0].min
      status.launchers = [f.ship_attribute('launcherSlotsLeft'), 0].min
      status.max_group_fitted = 0
      # @group_fitted.each_value do |v|
      #   status.max_group_fitted += [v[:max] - v[:current], 0].min
      # end
      validate_rigs(f, status)
      validate_slots(f, status)
      if status.to_h.values.all? { |i| i == 0 }
        Deterministic::Result::Success status
      else
        Deterministic::Result::Failure status
      end
    end

    private

    # TODO: can it be done on dogma level?
    def validate_rigs(f, status)
      status.wrong_size_rigs = 0
      f.rigs.each do |r|
        if r.attribute('rigSize') != f.ship_attribute('rigSize')
          status.wrong_size_rigs += 1
        end
      end
      calibration_used = f.rigs.inject(0) { |a, r| a + r.attribute('upgradeCost') }
      calibration_available = f.ship_attribute('upgradeCapacity')
      status.calibration = [0, calibration_available - calibration_used].min
    end

    # TODO: can it be done on dogma level?
    def validate_slots(f, status)
      [:lo, :med, :hi, :rig].each do |s|
        slots_used = f.modules(s).size
        slots_available = f.slots_available(s)
        status["#{s}_slots"] = [0, slots_available - slots_used].min
      end
    end
  end
end
