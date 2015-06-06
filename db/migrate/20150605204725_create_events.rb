class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :name
      t.string  :address
      t.datetime  :start_date_and_time
      t.float  :duration
      t.string  :description
      t.belongs_to  :organization
      t.string :event_type


      t.timestamps null: false
    end
  end
end
