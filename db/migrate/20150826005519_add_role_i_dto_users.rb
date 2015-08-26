class AddRoleIDtoUsers < ActiveRecord::Migration
  def change
    execute "UPDATE users SET role_id = (SELECT id FROM students WHERE students.username = users.username);"
    execute "UPDATE users SET role_type = 'Student';"
  end
end
