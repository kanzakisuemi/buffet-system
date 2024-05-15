class AddColumnEventsPerDayOnBuffets < ActiveRecord::Migration[7.0]
  def change
    add_column :buffets, :events_per_day, :integer, default: 1
  end
end
