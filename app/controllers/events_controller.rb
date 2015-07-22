class EventsController < ApplicationController
  def index
  end

  def today
    render 'layouts/events_list'
  end

  def tomorrow
    render '../layouts/events_list'
  end

  def next_week
    render '../layouts/events_list'
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
    puts "DATETIME!!"
    puts Event.find(ch1).start_date_and_time
    puts DateTime.now
    puts DateTime.now.beginning_of_day
    puts DateTime.now.tomorrow.to_date

    params["period"] = "this_week"

    if params["period"] == "today"
      puts "AMERICA"
      events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
      # events = Event.where(start_date_and_time.to_date Datetime.now.to_date)
      # events = Event.where("start_date_and_time = Datetime.now.to_date")
      # Datetime.now.to_date
    elsif params["period"] == "tomorrow"
      events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day + 1.days, DateTime.now.end_of_day + 1.days).all
    elsif params["period"] == "this_week"
      events = Event.where('start_date_and_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day + 6.days).all
    end

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