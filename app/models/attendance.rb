class Attendance < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  belongs_to :departue_location, class_name: "Location"
  validates_uniqueness_of :user_id, scope: :event_id
  validates_presence_of :user_id, :event_id
  YES = "Yes"
  NO = "No"
  MAYBE = "Maybe"

  def description
    case self.commitment_status
    when YES then "You are going to this event"
    when MAYBE then "You are watching this event"
    when NO then "You backed out of this event"
    end
  end

end
