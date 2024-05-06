class AddColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :payment_method, foreign_key: true
    add_column :orders, :grant_discount, :boolean, default: false
    add_column :orders, :charge_fee, :boolean, default: false
    add_column :orders, :extra_fee, :decimal, :precision => 8, :scale => 2
    add_column :orders, :discount, :decimal, :precision => 8, :scale => 2
    add_column :orders, :budget_details, :text
    add_column :orders, :budget, :decimal, :precision => 8, :scale => 2
    add_column :orders, :due_date, :date
  end
end
