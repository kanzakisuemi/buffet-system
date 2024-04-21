class CreateBuffetPayment < ActiveRecord::Migration[7.0]
  def change
    create_table :buffet_payments do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
