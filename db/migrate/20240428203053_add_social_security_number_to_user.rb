class AddSocialSecurityNumberToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :social_security_number, :string
  end
end
