class NudgesController < ApplicationController
	before_filter :require_verified_user, :require_student
	before_filter :nudges_enabled_globally?, only: [:new, :create]

	def index
	end

	def new
		@event = Event.find(params[:event_id])
		@nudge = Nudge.new(
			nudger: current_student,
			event: @event
		)
		@nudgeable_students = Student.nudgeable(current_student, @event)
	end

	def create
		@nudge = current_student.sent_nudges.build(nudge_params)
		if @nudge.save
			flash[:notice] = "You nudged #{@nudge.nudgee.username} to go to #{@nudge.event.name}"
			redirect_to dashboard_path
		else
			render 'new'
		end
	end

	def destroy
		@nudge = Nudge.find(params[:id])
		@event = @nudge.event
		if params[:accept]
			@nudge.accept!
			redirect_to new_event_attendance_path(@nudge.event)
		else
			@nudge.decline!
			redirect_to @event
		end
	end

	private

	def nudge_params
		params.require(:nudge).permit(:nudgee_id, :event_id)
	end

	def nudges_enabled_globally?
		if ENV["DISABLE_NUDGE_TEXTS"] == "TRUE"
			@event = Event.find(params[:id])
			flash[:notice] = "We’re sorry, but we have temporarily disabled nudges for all users while we correct an issue with the system. Please try your nudge again later."
			redirect_to @event
		#elsif current_user == User.first
		#	@event = Event.find(params[:id])
		#	flash[:notice] = "This example user has had nudging disabled."
		#	redirect_to @event
		end
	end

end
