class WelcomeController < ApplicationController
  def index
    sleep(2.0)
    redirect_to :action => "index", :controller => "events"
  end
end