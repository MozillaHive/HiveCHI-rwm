class EventsController < ApplicationController
  def index
    events = Event.all
    events_json = events.map do |event|
      event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    render json: events_json
  end
end