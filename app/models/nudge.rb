class Nudge < ActiveRecord::Base
	belongs_to :nudger, class_name: "Student", foreign_key: "nudger_id"
	belongs_to :nudgee, class_name: "Student", foreign_key: "nudgee_id"
	belongs_to :event
	validates_presence_of :nudger, :nudgee, :event
	validate :allowed_to_nudge?
	after_create :send_text

	def send_text
		# If we add a preference setting to disable SMS, check for that here
		account_sid = Rails.application.secrets.twilio_sid
		auth_token = Rails.application.secrets.twilio_auth_token
		client = Twilio::REST::Client.new account_sid, auth_token
		from = "+18443117433"
		client.account.messages.create(
				:from => from,
				:to => self.nudgee.user.phone,
				:body => "Hey #{self.nudgee.username}, #{self.nudger.username} wants to go to #{self.event.name} if you'll go too! Reply at http://#{ENV['HOSTNAME']}/events/#{self.event.id}"
			)
	end

	private

	def allowed_to_nudge?
		if self.nudgee && !self.nudgee.nudges_enabled
			errors.add(:nudgee, "has chosen not to receive nudges")
		end
	end

end
