class AddColumnToEventTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :event_types, :archived, :boolean, default: false
  end
end
