class MoveStudentData < ActiveRecord::Migration
  def change
    execute "INSERT INTO students (username, school_id, address, nudges_enabled, created_at, updated_at)" \
              " SELECT username, school_id, home_address, nudges_enabled, created_at, updated_at FROM users;"
  end
end
