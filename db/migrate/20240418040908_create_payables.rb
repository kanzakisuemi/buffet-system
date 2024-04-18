class CreatePayables < ActiveRecord::Migration[7.0]
  def change
    create_table :payables do |t|
      t.integer :buffet_id
      t.integer :payment_method_id
      t.timestamps
    end

    add_foreign_key :payables, :buffets, column: :buffet_id
    add_foreign_key :payables, :payment_methods, column: :payment_method_id
  end
end
