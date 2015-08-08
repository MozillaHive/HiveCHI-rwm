class Nudge < ActiveRecord::Base
	belongs_to :nudger, class_name: "User", foreign_key: "nudger_id"
	belongs_to :nudgee, class_name: "User", foreign_key: "nudgee_id"
	belongs_to :event
	validate :allowed_to_send?

	private

	def allowed_to_send?
		unless self.nudgee.nudges_enabled
			errors.add(:nudgee, "has chosen not to receive nudges")
		end
	end

end
