class NudgesController < ApplicationController
	before_filter :require_verified_user

	def new
		user = User.find(session[:user_id])
		@menu_options = user.school.students
		@menu_options = @menu_options.select{|s| s != user}
	end

	def create
		nudge = Nudge.create(nudger: User.find(session[:user_id]), nudgee: User.find(params[:nudgee]),event: Event.find(params[:id]))
		text_message(nudge)
		flash[:notice] = "You nudged #{nudge.nudgee.username} to go to #{nudge.event.name}"
		nudge.save
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
		from = "+12245209278" # Your Twilio number\

		client.account.messages.create(
    		:from => from,
    		:to => nudge.nudgee.phone,
    		:body => "Hey #{nudge.nudgee.username}, #{nudge.nudger.username} wants to go to #{nudge.event.name} with you. Log into your RideW/Me account to confirm."
  		)
	end

end
