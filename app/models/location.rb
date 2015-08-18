class Location < ActiveRecord::Base
	has_and_belongs_to_many :organizations
	has_many :events
	has_and_belongs_to_many :users
	has_many :schools
end
