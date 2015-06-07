class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many    :attendances
  has_many    :attendees , through: :attendances, source: :user
end
