class NudgesController < ApplicationController
	before_filter :require_verified_user
	before_filter :nudges_enabled_globally?, only: [:new, :create]

	def new
		@menu_options = User.where(nudges_enabled: true).where.not(id: current_user.id)
		@event = Event.find(params[:id])
	end

	def create
		@nudge = Nudge.new(
			nudger: current_user,
			nudgee: User.find(params[:nudgee]),
			event: Event.find(params[:id])
		)
		if @nudge.save
			@nudge.send_text!
			flash[:notice] = "You nudged #{nudge.nudgee.username} to go to #{nudge.event.name}"
			redirect_to dashboard_path
		else
			render 'new'
		end
	end

	def show
		@nudges_in = current_user.recieved_nudges
		@nudges_out = current_user.sent_nudges
	end

	private

	def nudges_enabled_globally?
		if ENV["DISABLE_NUDGE_TEXTS"] == "TRUE"
			@event = Event.find(params[:id])
			flash[:notice] = "We’re sorry, but we have temporarily disabled nudges for all users while we correct an issue with the system. Please try your nudge again later."
			redirect_to @event
		elsif current_user == User.first
			@event = Event.find(params[:id])
			flash[:notice] = "This example user has had nudging disabled."
			redirect_to @event
		end
	end

end
