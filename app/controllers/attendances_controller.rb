class AttendancesController < ApplicationController
  def new
    addresses_json = {
      schoolAddress: User.find_by_id(session[:user_id]).school.address,
      eventAddress: Event.find_by_id(session[:event_id]).address
    }
  end
end