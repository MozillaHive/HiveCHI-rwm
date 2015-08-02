class AllowNullDepartureType < ActiveRecord::Migration
  def up
    change_column_null(:attendances, :departure_type, true)
  end
  def down
    change_column_null(:attendances, :departure_type, false)
  end
end
