class Order < ApplicationRecord
  belongs_to :event_type
  belongs_to :user

  before_validation :generate_code 

  validates :code, :user, :event_type, :event_date, :guests_estimation, :status, presence: true

  enum status: { pending: 0, approved: 1, canceled: 2 }

  def humanized_status
    I18n.t("activerecord.attributes.order.status.#{status}", order: self)
  end

  def code_and_date
    "#{code} - #{I18n.localize(event_date)}"
  end

  def buffet
    event_type.buffet
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
