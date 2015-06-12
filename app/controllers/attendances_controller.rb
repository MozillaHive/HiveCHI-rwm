class AttendancesController < ApplicationController
  def new
    redirect_to "/events/"+params[:event_id] unless flash[:commitment]
  end

  def create
  	event = Event.find(params[:id])
  	Attendance.create(user: User.find(session[:user_id]), event: event,
  		departure_time: params[:departure_time],
  		method_of_transit: params[:method_of_transit],
  		commitment_status: params[:commitment_status])
  	flash[:notice] = "You signed up for #{event.name}"
  	redirect_to "/"
  end
end