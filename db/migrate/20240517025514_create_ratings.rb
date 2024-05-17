class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.text :review
      t.references :user, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
