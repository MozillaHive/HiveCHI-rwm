class AddNudgesEnabledToUsers < ActiveRecord::Migration
  def up
    add_column :users, :nudges_enabled, :boolean
  end
  
  def down
    remove_column :users, :nudges_enabled
  end
end
