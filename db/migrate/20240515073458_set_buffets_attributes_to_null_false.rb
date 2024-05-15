class SetBuffetsAttributesToNullFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_null :buffets, :social_name, false
    change_column_null :buffets, :corporate_name, false
    change_column_null :buffets, :company_registration_number, false
    change_column_null :buffets, :phone, false
    change_column_null :buffets, :email, false
    change_column_null :buffets, :address, false
    change_column_null :buffets, :neighborhood, false
    change_column_null :buffets, :city, false
    change_column_null :buffets, :state, false
    change_column_null :buffets, :zip_code, false
    change_column_null :buffets, :description, false
    change_column_null :buffets, :events_per_day, false
  end
end
