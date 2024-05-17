class Buffet < ApplicationRecord
  belongs_to :user
  has_many :event_types
  has_many :buffet_payments
  has_many :payment_methods, through: :buffet_payments
  has_many :orders, through: :event_types
  has_many :ratings

  validates :social_name, :corporate_name, :company_registration_number, :phone, :email, :address, :neighborhood, :city, :state, :zip_code, :description, :user_id, :events_per_day, presence: true
  validates :events_per_day, :phone, :zip_code, numericality: { only_integer: true }
  validates :state, length: { is: 2 }
  validates :phone, length: { in: 8..11 }
  validates :zip_code, length: { is: 8 }
  validates :email, format: { with: Devise.email_regexp }
  validates :user_id, :company_registration_number, uniqueness: true
  validate :check_company_registration_number

  def rating_average
    self.ratings.average(:score)
  end

  private

  def check_company_registration_number
    errors.add(:company_registration_number, 'deve ser válido') unless CNPJ.valid?(company_registration_number)
  end

end
