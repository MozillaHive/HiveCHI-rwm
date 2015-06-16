class WelcomeController < ApplicationController
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
      active_attends = User.find(session[:user_id]).attendances.select {|a| a.commitment_status != "No"}
      @user_events = []
      now = DateTime.now
      active_attends.each do |a|
        @user_events.push(a.event) unless (a.event.start_date_and_time + a.event.duration.hours) - now < 0
      end
      school = User.find(session[:user_id]).school
      @hot_events = Hash.new(0)
      school.students.each do |s|
        s.events_attended.each do |e|
          @hot_events[e] +=1 unless (e.start_date_and_time + e.duration.hours) - now < 0
        end
      end
      @events_arr = @hot_events.sort_by{|e,n| n}
      @events_arr.reverse!
      @hot_events_num = [5,@events_arr.length].min
  end
end