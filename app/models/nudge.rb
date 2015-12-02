class Nudge < ActiveRecord::Base
	belongs_to :nudger, class_name: "Student", foreign_key: "nudger_id"
	belongs_to :nudgee, class_name: "Student", foreign_key: "nudgee_id"
	belongs_to :event
	validates_presence_of :nudger, :nudgee, :event
	validate :allowed_to_nudge?
	after_create :send_text

	def send_text
		body = "Hey #{self.nudgee.username}, #{self.nudger.username} wants to go to #{self.event.name} if you'll go too! Reply at http://#{ENV['HOSTNAME']}/events/#{self.event.id}"
		nudgee.send_text(body)
	end

	def accept!
		body = "Hey #{nudger.username}, #{nudgee.username} accepted your nudge! They're going to #{event.name}."
		nudger.send_text(body)
		destroy
	end

	def decline!
		destroy
	end

	private

	def allowed_to_nudge?
		if self.nudgee && !self.nudgee.nudges_enabled
			errors.add(:nudgee, "has chosen not to receive nudges")
		end
	end

end
