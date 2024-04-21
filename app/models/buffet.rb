class Buffet < ApplicationRecord
  belongs_to :user
  has_many :event_types
  has_many :buffet_payments
  has_many :payment_methods, through: :buffet_payments

  validates :social_name, :corporate_name, :company_registration_number, :phone, :email, :address, :neighborhood, :city, :state, :zip_code, :description, presence: true
  validates :user_id, :company_registration_number, uniqueness: true
end
