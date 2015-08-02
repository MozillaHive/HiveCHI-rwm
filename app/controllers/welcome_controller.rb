class WelcomeController < ApplicationController
	before_filter :require_verified_user, except: :index

  #layout false
  def index
  #  sleep(2.0)
    if session[:user_id]
      redirect_to :action => "dashboard", :controller => "welcome"
    else
      redirect_to :action => "login", :controller => "session"
    end
  end

  def dashboard
    redirect_to :action => "parent_dashboard", :controller => "welcome" if session[:is_parent?]
    active_attends = current_user.attendances.select {|a| a.commitment_status != "No"}
		@school = current_user.school
    @user_events = []
    now = DateTime.now
    active_attends.each do |a|
      @user_events.push(a) unless (a.event.start_date_and_time + a.event.duration.hours) - now < 0
    end
    @user_events.sort_by! {|a| a.event.start_date_and_time}
		@trending_events = Event.popular_events(5)

    @nudges_in = current_user.recieved_nudges
    @nudges_out = current_user.sent_nudges
  end


  def parent_dashboard
    redirect_to :action => "dashboard", :controller => "welcome" unless session[:is_parent?]
    attends = current_user.attendances.select {|a| a.commitment_status != "No"}
    @today_events = []
    @future_events = []
    @past_events = []
    now = DateTime.now
    attends.each do |a|
      e = a.event
      if e.start_date_and_time+e.duration.hours < now
        @past_events.push(e)
      elsif e.start_date_and_time.to_date() == now.to_date()
        @today_events.push(e)
      else
        @future_events.push(e)
      end
    end
  end

end
