class PaymentMethod < ApplicationRecord
  has_many :buffet_payments
  has_many :buffets, through: :buffet_payments
  has_many :orders

  validates :name, presence: true, uniqueness: true
end
