class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:business_owner, :client]

  has_one :buffet
  has_many :orders
  has_many :messages

  validates :name, :role, presence: true
  validates :social_security_number, presence: true, if: :client?
  validates :social_security_number, uniqueness: true, if: :client?
  validate :check_social_security_number

  def humanized_role
    I18n.t("activerecord.attributes.user.roles.#{role}", user: self)
  end

  private

  def check_social_security_number
    return unless social_security_number.present?
    errors.add(:social_security_number, 'deve ser válido') unless CPF.valid?(social_security_number)
  end

  def self.role_options_for_select
    roles.map do |role, _|
      [I18n.t("activerecord.attributes.user.roles.#{role}"), role]
    end
  end 
end
