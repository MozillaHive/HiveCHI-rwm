class UserUniqueIndices < ActiveRecord::Migration
  def up
    add_index :users, [:username, :email], unique: true
  end
  def down
    remove_index :users, column: [:username, :email]
  end
end
