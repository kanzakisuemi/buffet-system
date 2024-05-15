class AddColumnToBuffet < ActiveRecord::Migration[7.0]
  def change
    add_column :buffets, :archived, :boolean, default: false
  end
end
