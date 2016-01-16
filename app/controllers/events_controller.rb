class EventsController < ApplicationController
  before_filter :require_verified_user, except: :show

  def index
    if params[:start_time]
      @events = Event.by_time(params[:start_time], params[:end_time])
    else
      @events = Event.future
    end
    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

  def show
    @rand_image_number = rand(1..10)
    unless current_user and current_user.verified?
      session[:redirect_url] = "/events/#{params[:id]}"
    end
    @event = Event.find(params[:id])
    @attend = Attendance.find_by(event: @event, student: current_student)
    @out_nudge = Nudge.find_by(event: @event, nudger: current_student)
    @in_nudge = Nudge.find_by(event: @event, nudgee: current_student)
    flash[:attendance] = @attend.id if @attend
  end

end
