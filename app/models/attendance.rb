class Attendance < ActiveRecord::Base
  belongs_to  :student
  belongs_to  :event
  validates_uniqueness_of :student_id, scope: :event_id
  validates_presence_of :student_id, :event_id
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
