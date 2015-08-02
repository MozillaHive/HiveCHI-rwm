class AttendancesController < ApplicationController
  before_filter :require_verified_user

  def new
    unless session[:commitment]
      flash[:redirect_url] = "/events/"+params[:event_id]
      redirect_to "/redirect"
    end
    @event = Event.find(params[:event_id])
    @attend_hash = {transit: [0,0,0], walking: [0,0,0], bicycling: [0,0,0]}
    @event.attendances.each do |a|
    if (a.commitment_status == "Yes" and a.user.school_id == current_user.school_id)
      @attend_hash[a.method_of_transit][index_from_dep_time(a.departure_type)] += 1
    end
  end

  def create
  	event = Event.find(params[:event_id])
  	Attendance.create(user: current_user, event: event,
  		departure_type: params[:departure_type],
  		method_of_transit: params[:method_of_transit],
  		commitment_status: params[:commitment_status])
  	flash[:notice] = "You signed up for #{event.name}"
    redirect_to event
  end

  def update
    Attendance.find(flash[:attendance]).update(commitment_status: params[:update_commit_status])
    flash[:notice] = "Your attendance has been updated"
    client_redirect "/dashboard"
  end

  def show
  	event = Event.find(params[:event_id])
    @attendance = Attendance.find(params[:id])
  end

  def index_from_dep_time(dep_time)
    if dep_time == "Early"
      return 0
    elsif dep_time == 'On Time'
      return 1
    else
      return 2
    end
  end
end

end