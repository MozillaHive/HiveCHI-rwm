class AddDepartureTypeToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :departure_type, :string
    change_column_null :attendances, :departure_type, false, default: "Early"
    remove_column :attendances, :departure_time
  end
end
