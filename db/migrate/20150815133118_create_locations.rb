class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.float :latitude
      t.float :longitude
      t.boolean :is_public
      

      t.timestamps null: false
    end
  end
end
