class Buffet < ApplicationRecord
  belongs_to :user
  has_many :event_types
  has_many :buffet_payments
  has_many :payment_methods, through: :buffet_payments
  has_many :orders, through: :event_types

  validates :social_name, :corporate_name, :company_registration_number, :phone, :email, :address, :neighborhood, :city, :state, :zip_code, :description, :user_id, presence: true
  validates :user_id, :company_registration_number, uniqueness: true
  validate :check_company_registration_number

  private

  def check_company_registration_number
    errors.add(:company_registration_number, 'deve ser válido') unless CNPJ.valid?(company_registration_number)
  end
end
