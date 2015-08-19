class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many    :attendances
  has_many    :attendees , through: :attendances, source: :user
  belongs_to :location

  def self.popular_events_by_school(school, number)
    popular_events = Event.future_events.sort_by do |event|
      -event.attendees.select { |attendee| attendee.school == school }.size
    end
    popular_events[0...number]
  end

  def self.popular_events(number)
    Event.select('events.*, count(attendances.id) AS attendance_count')
      .joins(:attendances)
      .group("events.id")
      .where('events.start_date_and_time > ?', Time.now)
      .order("attendance_count DESC")
      .limit(number)
  end

  def self.future_events
    Event.where("start_date_and_time > ?", Date.today.beginning_of_day)
      .includes(:attendances)
      .select { |event| (event.start_date_and_time + event.duration).future? }
  end

  def attendees_by_school(school)
    self.attendees.select { |attendee| attendee.school == school }.count
  end

end
