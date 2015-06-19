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
      @user_events = User.find(session[:user_id]).events_attended
      school = User.find(session[:user_id]).school
      @hot_events = Hash.new(0)
      school.students.each do |s|
        s.events_attended.each do |e|
          @hot_events[e] +=1
        end
      end
      @events_arr = @hot_events.sort_by{|e,n| n}
      @events_arr.reverse!
      @hot_events_num = 5
  end
end