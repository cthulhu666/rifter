module Rifter
  class Damage

    DAMAGE_TYPES = %i(em thermal kinetic explosive)

    def initialize(dmg = {})
      @value = dmg.to_h.dup
      @value.symbolize_keys!
      DAMAGE_TYPES.each { |dmg_type| @value[dmg_type] ||= 0 }
    end

    def *(multiplier)
      case multiplier
        when Hash
          Damage.new(@value.map { |k, v| [k, v * (multiplier[k] || 1.0)] })
        else
          Damage.new(@value.map { |k, v| [k, v * multiplier] })
      end

    end

    def +(damage)
      Damage.new(@value.map { |k, v| [k, v + damage[k]] })
    end

    def [](dmg_type)
      @value[dmg_type.to_sym]
    end

    def sum
      DAMAGE_TYPES.inject(0) do |sum, dmg_type|
        sum += @value[dmg_type]
        sum
      end
    end

    def to_h
      @value.to_h.dup
    end

    # see https://github.com/DarkFenX/Pyfa/blob/d60b288e0ea7313f5d6aeb476430d0d928f6aa79/eos/graph/fitDps.py#L79
    def calculate_missile_damage(launcher:, target:)
      s = target.signature_radius
      e = launcher.aoe_cloud_size
      ve = target.max_velocity
      vt = launcher.aoe_velocity
      drf = launcher.aoe_damage_reduction_factor
      drs = launcher.aoe_damage_reduction_sensitivity

      sig_radius_factor = s / e
      velocity_factor = (vt / e * s / ve)**(Math.log(drf)/Math.log(5.5))

      self * [1, sig_radius_factor, velocity_factor].min
    end

    # see https://github.com/DarkFenX/Pyfa/blob/d60b288e0ea7313f5d6aeb476430d0d928f6aa79/eos/graph/fitDps.py#L96
    def calculate_turret_damage(turret:, target:, distance:, angle:, velocity:)
      chance_to_hit = turret.chance_to_hit(target: target, distance: distance, angle: angle, velocity: velocity)
      if chance_to_hit > 0.01
        multiplier = (chance_to_hit ** 2 + chance_to_hit + 0.0499) / 2
      else
        multiplier = chance_to_hit * 3
      end
      #if dmg_scaling = turret['turret_damage_scaling_radius']
      #  targetSigRad = data["signatureRadius"]
      #        multiplier = min(1, (float(targetSigRad) / dmgScaling) ** 2)
      #end
      self * multiplier
    end

  end
end
