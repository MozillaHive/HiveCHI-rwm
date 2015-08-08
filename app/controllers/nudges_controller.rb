class NudgesController < ApplicationController
	before_filter :require_verified_user

	def new
		@menu_options = User.all
		@menu_options = @menu_options.select{|s| s != current_user}
		@event = Event.find(params[:id])
	end

	def create
		if ENV["DISABLE_NUDGE_TEXTS"] != "TRUE"
			nudge = Nudge.create(nudger: User.find(session[:user_id]), nudgee: User.find(params[:nudgee]),event: Event.find(params[:id]))
			text_message(nudge)
			flash[:notice] = "You nudged #{nudge.nudgee.username} to go to #{nudge.event.name}"
			nudge.save
		else
			flash[:notice] = "We’re sorry, but we have temporarily disabled nudges for all users while we correct an issue with the system. Please try your nudge again later."
		end

		client_redirect "/dashboard"
	end

	def show
		user = User.find(session[:user_id])
		@nudges_in = user.recieved_nudges
		@nudges_out = user.sent_nudges
	end

	private
	def text_message(nudge)
		account_sid = Rails.application.secrets.twilio_sid
		auth_token = Rails.application.secrets.twilio_auth_token
		client = Twilio::REST::Client.new account_sid, auth_token
		from = "+18443117433" # Your Twilio number\

		client.account.messages.create(
    		:from => from,
    		:to => nudge.nudgee.phone,
    		:body => "Hey #{nudge.nudgee.username}, #{nudge.nudger.username} wants to go to #{nudge.event.name} if you'll go too! Reply at #{request.base_url+"/events/"+params[:id]}"
  		)
	end

end
