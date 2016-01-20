class AddMinimumAgeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :minimum_age, :integer
  end
end
