class UseLocations < ActiveRecord::Migration
  def change
  	add_belongs_to :schools, :location
  	add_belongs_to :events, :location
  	add_belongs_to :users, :home 
  	add_belongs_to :attendances, :departure_location
  	remove_column :schools, :address
  	remove_column :events, :address
  	remove_column :users, :home_address
  end
end
