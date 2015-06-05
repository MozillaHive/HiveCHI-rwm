class User < ActiveRecord::Base
  belongs_to :school
  has_many :attendances
  has_many :events_attended, through: :attendances, source: :events
end
