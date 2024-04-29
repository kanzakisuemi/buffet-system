class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:business_owner, :client]

  validates :name, :role, presence: true

  validates :social_security_number, presence: true, on: :update, if: :client?

  validates :social_security_number, uniqueness: true, if: :client?

  has_one :buffet

  def humanized_role
    I18n.t("activerecord.attributes.user.roles.#{role}", user: self)
  end

  private

  def self.role_options_for_select
    roles.map do |role, _|
      [I18n.t("activerecord.attributes.user.roles.#{role}"), role]
    end
  end

end
