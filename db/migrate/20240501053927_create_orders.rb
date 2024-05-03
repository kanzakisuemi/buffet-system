class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :event_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :event_date
      t.integer :guests_estimation
      t.text :event_details
      t.text :event_address
      t.integer :status, default: 0
      t.string :code

      t.timestamps
    end
  end
end
