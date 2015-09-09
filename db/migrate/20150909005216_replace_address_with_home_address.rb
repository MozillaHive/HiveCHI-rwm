class ReplaceAddressWithHomeAddress < ActiveRecord::Migration
  def change
    rename_column :students, :address, :home_address
  end
end
