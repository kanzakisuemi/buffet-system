class ChangeUserToUniqueInBuffets < ActiveRecord::Migration[7.0]
  def change
    change_table :buffets do |t|
      t.index :user_id, unique: true

      add_foreign_key :buffets, :users, column: :user_id
    end
  end
end
