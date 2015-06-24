class AttendancesController < ApplicationController
  def new
    redirect_to "/events/"+params[:event_id] unless session[:commitment]
  end

  def create
  	event = Event.find(params[:id])
  	Attendance.create(user: User.find(session[:user_id]), event: event,
  		departure_time: params[:departure_time],
  		method_of_transit: params[:method_of_transit],
  		commitment_status: session[:commitment])
  	flash[:notice] = "You signed up for #{event.name}"
    session[:commitment] = nil
  	redirect_to "/"
  end

  def update
    Attendance.find(flash[:attendance]).update(commitment_status: params[:update_commit_status])
    flash[:notice] = "Your attendance has been updated"
    redirect_to "/"
  end
end