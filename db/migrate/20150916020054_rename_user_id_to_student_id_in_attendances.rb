class RenameUserIdToStudentIdInAttendances < ActiveRecord::Migration
  def change
    rename_column :attendances, :user_id, :student_id
  end
end
