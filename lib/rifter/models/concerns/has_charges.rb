module HasCharges
  extend ActiveSupport::Concern

  included do
    field :charge_size, type: Integer

    has_and_belongs_to_many :charges, class_name: 'Rifter::Charge'

    before_save do
      self.charge_size = miscellaneous_attributes.charge_size.to_i rescue nil
    end

    def charge_valid?(charge)
      charge.id.in?(charge_ids)
    end

    class << self
      def update_charge_size
        where(charge_size: nil).each { |c| c.save }
      end
    end
  end

end
