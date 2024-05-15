class SetEventTypesAttributesToNullFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_null :event_types, :category, false
    change_column_null :event_types, :name, false
    change_column_null :event_types, :description, false
    change_column_null :event_types, :minimal_people_capacity, false
    change_column_null :event_types, :maximal_people_capacity, false
    change_column_null :event_types, :default_duration_minutes, false
    change_column_null :event_types, :food_menu, false
    change_column_null :event_types, :base_price, false
    change_column_null :event_types, :weekend_fee, false
    change_column_null :event_types, :per_person_fee, false
    change_column_null :event_types, :per_person_weekend_fee, false
    change_column_null :event_types, :per_hour_fee, false
    change_column_null :event_types, :per_hour_weekend_fee, false
  end
end
