class Nudge < ActiveRecord::Base
	belongs_to :nudger, class_name: "User", foreign_key: "nudger_id"
	belongs_to :nudgee, class_name: "User", foreign_key: "nudgee_id"
	belongs_to :event
	validate :allowed_to_send?

	def send_text!
		account_sid = Rails.application.secrets.twilio_sid
		auth_token = Rails.application.secrets.twilio_auth_token
		client = Twilio::REST::Client.new account_sid, auth_token
		from = "+18443117433" # Your Twilio number
		client.account.messages.create(
				:from => from,
				:to => self.nudgee.phone,
				:body => "Hey #{self.nudgee.username}, #{self.nudger.username} wants to go to #{self.event.name} if you'll go too! Reply at http://#{ENV['HOSTNAME']}/events/#{self.event.id}"
			)
	end
	
	private

	def allowed_to_send?
		unless self.nudgee.nudges_enabled
			errors.add(:nudgee, "has chosen not to receive nudges")
		end
	end

end
