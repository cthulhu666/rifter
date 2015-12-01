module Rifter
  module Rig
    extend ActiveSupport::Concern

    included do
      field :rig_size, type: Integer
      field :upgrade_cost, type: Integer

      before_save do
        self.rig_size = begin
                          miscellaneous_attributes.rig_size.to_i
                        rescue
                          nil
                        end
        self.upgrade_cost = begin
                              miscellaneous_attributes.upgrade_cost.to_i
                            rescue
                              nil
                            end
      end

      delegate :drawback, to: :miscellaneous_attributes
    end

    def setup(fitted_module)
      if drawback = miscellaneous_attributes.try(:drawback)
        fitted_module['drawback'] = drawback
      end
      fitted_module['upgrade_cost'] = miscellaneous_attributes.upgrade_cost
    end
  end
end
