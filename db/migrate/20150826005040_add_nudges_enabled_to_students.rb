class AddNudgesEnabledToStudents < ActiveRecord::Migration
  def change
    add_column :students, :nudges_enabled, :boolean
  end
end
