class AttendancesController < ApplicationController
  def new
   addresses_json = {
      schoolAddress: User.find_by(id: session[:user_id]).school.address,
      eventAddress: Event.find_by_id(params[:event_id]).address
    }

    File.open("public/addresses.json","w") do |f|
      f.write(addresses_json.to_json)
    end
    # render json: addresses_json

  #     events_json = []
  # Event.all.each do |event|
  #   event_json = {
  #     "id" => event.id,
  #     "start" => event.start_at,
  #     "end" => event.end_at,
  #     "title" => event.name,
  #     "body" => event.event_description,
  #     "status" => event.status
  #   }
  #   events_json << event_json
  # end
  # File.open("public/event.json","w") do |f|
  #   f.write(events_json.to_json)
  # end
  end
end