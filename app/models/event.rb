class Event < ActiveRecord::Base
  belongs_to  :organization
  has_many    :attendances
  has_many    :attendees , through: :attendances, source: :student

  TYPES = %w(Football Camp Recreational Basketball Tennis Aquatic Gymnastics
             Fitness Other)

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
        .order("start_date_and_time")
        .includes(:attendances)
        .select(&:not_over?)
    else
      Event.where("start_date_and_time BETWEEN ? AND ?",
            start_time.to_date.beginning_of_day, start_time.to_date.end_of_day)
        .order("start_date_and_time")
        .includes(:attendances)
        .select(&:not_over?)
    end
  end

  def self.future_events
    Event.where("start_date_and_time > ?", Date.today.beginning_of_day)
      .order("start_date_and_time")
      .includes(:attendances)
      .select(&:not_over?)
  end

  def not_over?
    (start_date_and_time + duration.hours).future?
  end

end
