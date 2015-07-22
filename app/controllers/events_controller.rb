class EventsController < ApplicationController
  before_filter :require_verified_user

  def index
  end

    # preferences_json = {
    #   preference_1: User.find_by_id(session[:user_id]).preference_1,
    #   preference_2: User.find_by_id(session[:user_id]).preference_2,
    #   preference_3: User.find_by_id(session[:user_id]).preference_3
    # }

    # render json: {
    #   :events => events_json,
    #   :preferences => preferences_json
    # }

  def all
    events = Event.all
    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    # events = ["bob", "bill"]

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
    # render :json => events
  end

  def show
    @event = Event.find(params[:id])
    @attend = Attendance.find_by(event: @event, user_id: session[:user_id])
    @out_nudge = Nudge.find_by(event: @event, nudger_id: session[:user_id])
    @in_nudge = Nudge.find_by(event: @event, nudgee_id: session[:user_id])
    flash[:attendance] = @attend.id if @attend
    puts @attend
    puts @out_nudge
    puts @in_nudge
  end

end
