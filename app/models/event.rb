class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many    :attendances
  has_many    :attendees , through: :attendances, source: :user

  def self.popular_events_by_school(school, number)
    popular_events = Event.future_events.sort_by do |event|
      -event.attendees.select { |attendee| attendee.school == school }.size
    end
    popular_events[0...number]
  end

  def self.popular_events(number)
    Event.future_events.sort_by { |event| -event.attendees.count }[0...number]
  end

  def self.future_events
    Event.all.select do |event|
      (event.start_date_and_time + event.duration).future?
    end
  end

  def attendees_by_school(school)
    self.attendees.select { |attendee| attendee.school == school }.count
  end

end
