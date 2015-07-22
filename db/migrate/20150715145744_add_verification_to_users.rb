class AddVerificationToUsers < ActiveRecord::Migration
  def up
    add_column :users, :email_token, :string
    add_column :users, :phone_token, :string
    add_column :users, :email_verified, :boolean
    add_column :users, :phone_verified, :boolean
  end
  def down
    remove_column :users, :email_token
    remove_column :users, :phone_token
    remove_column :users, :email_verified
    remove_column :users, :phone_verified
  end
end
