class Order < ApplicationRecord
  belongs_to :event_type
  belongs_to :user
  belongs_to :payment_method, optional: true

  before_validation :generate_code 

  validates :code, :user, :event_type, :event_date, :guests_estimation, :status, presence: true
  validates :due_date, comparison: { less_than: :event_date }, if: -> { due_date.present? }
  validates :guests_estimation, numericality: { less_than_or_equal_to: ->(order) { order.event_type.maximal_people_capacity } }

  validate :event_date_is_future

  enum status: { pending: 0, approved: 1, confirmed: 2, canceled: 3 }

  def total_price
    if self.charge_fee?
      event_price + self.extra_fee
    elsif self.grant_discount?
      event_price - self.discount
    elsif self.charge_fee? && self.grant_discount?
      event_price + self.extra_fee - self.discount
    else
      event_price
    end
  end

  def event_price
    if self.event_date.on_weekend?
      price = self.event_type.apply_fee(self.event_type.base_price, self.event_type.weekend_fee)
      extra_person_fee = self.event_type.apply_fee(self.event_type.per_person_fee, self.event_type.per_person_weekend_fee)
      if self.guests_estimation > self.event_type.minimal_people_capacity
        price += (self.guests_estimation - self.event_type.minimal_people_capacity) * extra_person_fee
      end
      price
    elsif self.event_date.on_weekday?
      price = self.event_type.base_price
      extra_person_fee = self.event_type.per_person_fee
      if self.guests_estimation > self.event_type.minimal_people_capacity
        price += (self.guests_estimation - self.event_type.minimal_people_capacity) * extra_person_fee
      end
      price
    end
  end

  def payment_methods_options_for_select
    self.buffet.payment_methods.map do |payment_method, _|
      [payment_method.name, payment_method.id]
    end
  end

  def humanized_status
    I18n.t("activerecord.attributes.order.status.#{status}", order: self)
  end

  def code_and_date
    "#{code} - #{I18n.localize(event_date)}"
  end

  def buffet
    event_type.buffet
  end

  private

  def event_date_is_future
    return if event_date.blank?
    if event_date < Date.current
      errors.add(:event_date, 'deve ser uma data futura')
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
