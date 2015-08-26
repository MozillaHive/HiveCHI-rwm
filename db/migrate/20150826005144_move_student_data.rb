class MoveStudentData < ActiveRecord::Migration
  def change
    execute "INSERT INTO students (username, school_id, address, nudges_enabled)" \
              "SELECT (username, school_id, address, nudges_enabled) FROM users;"
  end
end
