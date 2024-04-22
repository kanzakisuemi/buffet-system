class AddColumnsToEventType < ActiveRecord::Migration[7.0]
  def change
    add_column :event_types, :base_price, :decimal, :precision => 8, :scale => 2
    add_column :event_types, :weekend_fee, :integer
    add_column :event_types, :per_person_fee, :decimal, :precision => 8, :scale => 2
    add_column :event_types, :per_person_weekend_fee, :integer
    add_column :event_types, :per_hour_fee, :decimal, :precision => 8, :scale => 2
    add_column :event_types, :per_hour_weekend_fee, :integer
  end
end
