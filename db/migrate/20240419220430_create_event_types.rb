class CreateEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :event_types do |t|
      t.integer :category
      t.string :name
      t.text :description
      t.integer :minimal_people_capacity
      t.integer :maximal_people_capacity
      t.integer :default_duration_minutes
      t.text :food_menu
      t.boolean :alcoholic_drinks
      t.boolean :decoration
      t.boolean :parking_service
      t.boolean :location_flexibility
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
