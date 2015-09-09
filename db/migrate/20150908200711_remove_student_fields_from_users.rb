class RemoveStudentFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :username
    remove_column :users, :home_address
    remove_column :users, :school_id
    remove_column :users, :preference_1
    remove_column :users, :preference_2
    remove_column :users, :preference_3
    remove_column :users, :parent_password
  end
end
