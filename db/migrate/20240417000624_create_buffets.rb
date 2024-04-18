class CreateBuffets < ActiveRecord::Migration[7.0]
  def change
    create_table :buffets do |t|
      t.string :social_name
      t.string :corporate_name
      t.string :company_registration_number
      t.string :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
