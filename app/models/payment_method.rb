class PaymentMethod < ApplicationRecord
  has_many :buffet_payments
  has_many :buffets, through: :buffet_payments

  validates :name, presence: true, uniqueness: true
end
