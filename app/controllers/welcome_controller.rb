class WelcomeController < ApplicationController
	#layout false
  def index
    sleep(2.0)
    if session[:user_id]
      redirect_to :action => "dashboard", :controller => "welcome"
    else
      redirect_to :action => "login", :controller => "session"
    end
  end

  def dashboard

  end
end