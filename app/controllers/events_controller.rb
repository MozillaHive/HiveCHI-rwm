class EventsController < ApplicationController
  def index
    time = params[:time]
    respond_to do |format|
      format.js { render :js => "my_function();" }
    end
    # respond_to do |format|
      # format.html
      # format.js
      # render :js => "eventsRequest(" + time + ");"
    # end
  end

  def today
    events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day + 1.days, DateTime.now.end_of_day + 1.days).all

    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
  end

  def tomorrow
    events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day + 1.days, DateTime.now.end_of_day + 1.days).all

    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
  end

  def this_week
    events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day + 6.days).all

    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
  end

  def all
    events = Event.all

    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
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