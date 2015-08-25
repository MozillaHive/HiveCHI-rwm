class AttendancesController < ApplicationController
  before_filter :require_verified_user

  def new
    @event = Event.find(params[:event_id])
    @user = current_user
    # We currently don't need this if/then because events#show renders a
    # different button depending on commitment. However, we might want to change
    # that later.
    if (@attendance = Attendance.find_by(user: @user, event: @event))
      redirect_to edit_event_attendance_path(@event, @attendance)
    else
      @attendance = Attendance.new
    end
    @attend_hash = {transit: [0,0,0], walking: [0,0,0], bicycling: [0,0,0]}
    @event.attendances.each do |a|
      if (a.commitment_status == "Yes" and a.user.school_id == current_user.school_id)
        @attend_hash[a.method_of_transit.to_sym()][index_from_dep_time(a.departure_type)] += 1
      end
    end
  end

  def create
  	@event = Event.find(params[:event_id])
  	Attendance.create(user: current_user, event: @event,
  		departure_type: params[:departure_type],
  		method_of_transit: params[:method_of_transit],
  		commitment_status: params[:commitment_status])
  	flash[:notice] = "You signed up for #{@event.name}"
    if (params[:commitment_status] == "Maybe" && session[:is_parent?])
      text_student
    end
    redirect_to controller: :welcome, action: :dashboard
  end

  def edit
    @event = Event.find(params[:event_id])
    @attendance = Attendance.find_by(user: current_user, event: @event)
    @attend_hash = {transit: [0,0,0], walking: [0,0,0], bicycling: [0,0,0]}
    @event.attendances.each do |a|
      if (a.commitment_status == "Yes" and a.user.school_id == current_user.school_id)
        @attend_hash[a.method_of_transit.to_sym()][index_from_dep_time(a.departure_type)] += 1
      end
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @attendance = Attendance.find_by(user: current_user, event: @event)
    @attendance.update(
      departure_type: params[:departure_type],
      method_of_transit: params[:method_of_transit],
      commitment_status: params[:commitment_status])
    flash[:notice] = "You signed up for #{@event.name}"
    if (params[:commitment_status] == "Maybe" && session[:is_parent?])
      text_student
    end
    redirect_to controller: :welcome, action: :dashboard
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


  def destroy
    @attendance = Attendance.find(params[:id])
    @event = Event.find(params[:event_id])
    @attendance.update(commitment_status: "No")
    redirect_to controller: :welcome, action: :dashboard
  end

  private
  def text_student
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_auth_token
    client = Twilio::REST::Client.new account_sid, auth_token
    from = Rails.application.secrets.twilio_originating_number

    client.account.messages.create(
        :from => from,
        :to => current_user.phone,
        :body => "Hey #{current_user.username}, your parent/guardian wants you to check out #{@event.name}. Reply at #{request.base_url+"/events/"+@event.id.to_s}"
      )
  end
end
