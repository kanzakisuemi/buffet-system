class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:business_owner, :client]

  private

  def self.role_options_for_select
    roles.map do |role, _|
      [I18n.t("activerecord.attributes.user.roles.#{role}"), role]
    end
  end
end
