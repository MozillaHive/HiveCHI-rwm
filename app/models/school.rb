class School < ActiveRecord::Base
  has_many :students, class_name: "User"
  belongs_to :location
end
