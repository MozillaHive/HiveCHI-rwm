class Attendance < ActiveRecord::Base
  belongs_to  :student
  belongs_to  :event
  validates_uniqueness_of :student_id, scope: :event_id
  validates_presence_of :student_id, :event_id
  YES = "Yes"
  NO = "No"
  MAYBE = "Maybe"

  def message
    case self.commitment_status
    when YES then "You signed up for #{event.name}"
    when MAYBE then "You are now watching #{event.name}"
    when NO then "You backed out of #{event.name}"
    end
  end

  def description
    case self.commitment_status
    when YES then "You are going to this event"
    when MAYBE then "You are watching this event"
    when NO then "You backed out of this event"
    end
  end

  def short_description
    case self.commitment_status
    when YES then "Going"
    when MAYBE then "Watching"
    when NO then "Backed out"
    end
  end

end
