class AttendancesController < ApplicationController
  def new
    if request.xhr?
     @addresses_json = {
        schoolAddress: User.find_by(id: session[:user_id]).school.address,
        eventAddress: Event.find_by_id(params[:event_id]).address
      }
    end
    # render json: addresses_json
  end
end