class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many    :attendances
  has_many    :students_attending, through: :attendances, source: :user
end
