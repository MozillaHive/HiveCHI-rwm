class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to  :event
      t.belongs_to  :user
      t.datetime    :departure_time
      t.string      :commitment_status
      t.string      :method_of_transit
      t.timestamps  null: false
    end
  end
end
