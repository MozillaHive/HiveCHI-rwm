class AddCanNudgeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :can_nudge, :boolean
  end
end
