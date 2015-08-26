class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many    :attendances
  has_many    :attendees , through: :attendances, source: :user

  TYPES = %w(Football Camp Recreational Basketball Tennis Aquatic Gymnastics
             Fitness Other)

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

  def self.by_time(start_time, end_time)
    if end_time
      Event.where("start_date_and_time BETWEEN ? AND ?", start_time, end_time)
        .includes(:attendances)
        .order("start_date_and_time")
        .select(&:not_over?)
    else
      Event.where(start_date_and_time: start_time)
        .includes(:attendances)
        .order("start_date_and_time")
        .select(&:not_over?)
    end
  end

  def self.future_events
    Event.where("start_date_and_time > ?", Date.today.beginning_of_day)
      .includes(:attendances)
      .order("start_date_and_time")
      .select(&:not_over?)
  end

  def attendees_by_school(school)
    attendees.select { |attendee| attendee.school == school }.count
  end

  def not_over?
    (start_date_and_time + duration).future?
  end

end
