class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :username
      t.string  :password_digest
      t.string  :parent_password
      t.string  :home_address
      t.string :phone
      t.belongs_to  :school
      t.string  :preference_1
      t.string  :preference_2
      t.string  :preference_3

      t.timestamps null: false
    end
  end
end
