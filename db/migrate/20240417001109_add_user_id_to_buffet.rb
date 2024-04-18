class AddUserIdToBuffet < ActiveRecord::Migration[7.0]
  def change
    add_column :buffets, :user_id, :integer
    add_foreign_key :buffets, :users, column: :user_id
  end
end
