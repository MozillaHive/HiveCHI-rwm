class Nudge < ActiveRecord::Base
	belongs_to :nudger, class_name: "Student", foreign_key: "nudger_id"
	belongs_to :nudgee, class_name: "Student", foreign_key: "nudgee_id"
	belongs_to :event
	validates_presence_of :nudger, :nudgee, :event
	validates :nudger_id, presence: true,
		uniqueness: { scope: [:nudgee_id, :event_id], message: "has already nudged this person to attend this event" }
	validates :nudgee_id, presence: true
	validates :event_id, presence: true
	validate :allowed_to_nudge?, :sender_and_recipient_differ?
	after_create :send_text

	def accept!
		body = "Hey #{nudger.username}, #{nudgee.username} accepted your nudge! They're going to #{event.name}."
		nudger.send_text(body)
		destroy
	end

	def decline!
		destroy
	end

	private

	def send_text
		body = "Hey #{nudgee.username}, #{nudger.username} wants to go to #{event.name} if you'll go too! Reply at http://#{ENV['HOSTNAME']}/events/#{event.id}"
		nudgee.send_text(body)
	end

	def allowed_to_nudge?
		if nudgee && !nudgee.nudges_enabled
			errors.add(:nudgee, "has chosen not to receive nudges")
		end
	end

	def sender_and_recipient_differ?
		if nudger == nudgee
			errors.add(:nudgee, "cannot be same as sender")
		end
	end

end
