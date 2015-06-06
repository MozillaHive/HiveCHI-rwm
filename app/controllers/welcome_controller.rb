class WelcomeController < ApplicationController
  def index
    sleep(2.0)
    if current_user
      redirect_to :action => "dashboard", :controller => "welcome"
    else
      redirect_to :action => "login", :controller => "session"
    end
  end

  def dashboard
  end
end