class User < ActiveRecord::Base
  has_secure_password
  belongs_to :school
  has_many :attendances
  has_many :events_attended, through: :attendances, source: :event
end
