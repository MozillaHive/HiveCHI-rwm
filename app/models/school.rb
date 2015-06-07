class School < ActiveRecord::Base
  has_many :students, class_name: "User"
end
