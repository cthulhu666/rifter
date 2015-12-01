module Rifter
  module Modifiers
    def apply_modifiers(context = self)
      evaluate_lambdas(modifiers)
      the_modifiers = percentages_to_multipliers(modifiers)

      flat = the_modifiers.select { |m| m[3] == :flat }
      multipliers = the_modifiers.select { |m| m[2] == false && m[3] == :multiplier }
      penalized_multipliers = the_modifiers.select { |m| m[2] == true && m[3] == :multiplier }

      flat.each do |m|
        original_val = get_value(context, m[0])
        set_value(context, m[0], m[1] + original_val)
      end

      multipliers.each do |m|
        original_val = get_value(context, m[0])
        set_value(context, m[0], original_val * m[1])
      end

      penalized_multipliers.group_by(&:first).each do |attr, arr|
        increases = arr.select { |m| m[1] >= 1.0 }.sort_by { |m| -m[1] }
        decreases = arr.select { |m| m[1] < 1.0 }.sort_by { |m| m[1] }
        [increases, decreases].each do |a|
          a.each_with_index do |m, i|
            original_val = get_value(context, attr)
            modifier = original_val * m[1] - original_val
            set_value(context, attr, original_val + modifier * ShipModule::STACKING_PENALTY[i])
          end
        end
      end
    end

    def boost_attribute(name, value, type: :percent, stacking_penalty: false, nested_property: nil)
      # TODO: Rails.logger.debug "Boosting attribute: #{self} #{name} #{value} #{type}"
      modifiers << [[name, nested_property], value, stacking_penalty, type]
    end

    def get_value(context, arr)
      val = context.send("#{arr.first}")
      val = val[arr.last] if arr.last
      val
    end
    private :get_value

    def set_value(context, arr, value)
      if arr.last
        context.send("#{arr.first}")[arr.last] = value
      else
        context.send("#{arr.first}=", value)
      end
    end
    private :set_value

    def evaluate_lambdas(modifiers)
      modifiers.each do |m|
        m[1] = m[1].call if m[1].is_a?(Proc)
      end
    end
    private :evaluate_lambdas

    def percentages_to_multipliers(modifiers)
      modifiers.select { |m| m.last == :percent }.each do |m|
        m[3] = :multiplier
        m[1] = 1.0 + m[1] / 100.0
      end
      modifiers
    end
    private :percentages_to_multipliers
  end
end
