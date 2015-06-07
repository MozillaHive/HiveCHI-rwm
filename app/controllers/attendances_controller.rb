class AttendancesController < ApplicationController
  def new
   addresses_json = {
      schoolAddress: current_user.school.address,
      eventAddress: Event.find_by_id(params[:event_id]).address
    }
    render json: addresses_json
  end
end