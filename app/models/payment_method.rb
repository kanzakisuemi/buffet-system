class PaymentMethod < ApplicationRecord
  has_many :buffet_payments
  has_many :buffets, through: :buffet_payments

  validates :name, presence: true, uniqueness: true
end

  # enum payment_type: [:credit_card, :debit_card, :pix, :bank_transfer, :bill, :cash]
  
  # def humanized_payment_type
  #   I18n.t("activerecord.attributes.payment_method.payment_types.#{payment_type}", payment_type: self)
  # end

  # private

  # def self.payment_options_for_select
  #   payment_types.map do |payment_type, _|
  #     [I18n.t("activerecord.attributes.payment_method.payment_types.#{payment_type}"), payment_type]
  #   end
  # end

