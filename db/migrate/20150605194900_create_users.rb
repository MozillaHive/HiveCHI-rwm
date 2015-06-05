class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :username
      t.string  :password_digest
      t.string  :parent_password_digest
      t.string  :home_address
      t.belongs_to  :school_id

      t.timestamps null: false
    end
  end
end
