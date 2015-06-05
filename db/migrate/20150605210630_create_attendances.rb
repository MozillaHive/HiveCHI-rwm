class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to  :event
      t.belongs_to  :user
      t.string      :estimated_arrival_time
      t.string      :commitment_status
      t.timestamps null: false
    end
  end
end
