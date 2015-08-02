class EventsController < ApplicationController
  before_filter :require_verified_user

  def index
    # time = params[:time]
    # respond_to do |format|
    #   format.js { render :js => "my_function();" }
    # end
    # respond_to do |format|
      # format.html
      # format.js
      # render :js => "eventsRequest(" + time + ");"
    # end
    # render '../layouts/events_list.html.erb'
  end

  def today
    puts "TODAY"
    events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all

    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
  end

  def tomorrow
    puts "TOMORROW"
    events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day + 1.days, DateTime.now.end_of_day + 1.days).all

    @events_json = events.map do |event|
        event.as_json.merge(:numberOfAttendees => event.attendances.count)
    end

    respond_to do |format|
      format.json {render json: @events_json, :status => :ok}
    end
  end

  def this_week
    puts "THISWEEK"
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

  def store_user_commitment
   if params[:commitment]
      session[:commitment] = params[:commitment]
      flash[:redirect_url] = "/events/#{params[:id]}/attendances/new"
      redirect_to "/redirect"
    else
      flash[:redirect_url] = "/events/#{params[:id]}"
      redirect_to "/redirect"
    end
  end

end
