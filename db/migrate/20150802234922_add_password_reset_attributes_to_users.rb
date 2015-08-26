class AddPasswordResetAttributesToUsers < ActiveRecord::Migration
  def up
    add_column :users, :inactive, :boolean
    add_column :users, :password_reset_token, :string
  end
  def down
    remove_column :users, :inactive
    remove_column :users, :password_reset_token
  end
end
