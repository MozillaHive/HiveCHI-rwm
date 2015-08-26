class AddRoleIndexToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :role, polymorphic: true
    end
  end
end
