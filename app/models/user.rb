class User < ActiveRecord::Base
  has_secure_password
  belongs_to :school
  has_many :attendances
  has_many :events_attended, through: :attendances, source: :event
  has_many :sent_nudges, class_name: "Nudge", foreign_key: :nudger_id
  has_many :recieved_nudges, class_name: "Nudge", foreign_key: :nudgee_id
end
