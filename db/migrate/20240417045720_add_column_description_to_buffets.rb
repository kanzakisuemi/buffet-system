class AddColumnDescriptionToBuffets < ActiveRecord::Migration[7.0]
  def change
    add_column :buffets, :description, :text
  end
end
