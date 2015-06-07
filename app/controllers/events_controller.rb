class EventsController < ApplicationController
  def index
    events = Event.all
    events_json = events.map do |event|
      event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    preferences_json = {
      preference_1: User.find_by_id(session[:user_id]).preference_1,
      preference_2: User.find_by_id(session[:user_id]).preference_2,
      preference_3: User.find_by_id(session[:user_id]).preference_3
    }

    render json: {
      :events => events_json,
      :preferences => preferences_json
    }
  end
end