class Nudge < ActiveRecord::Base
	belongs_to :nudger, class_name: "User", foreign_key: "nudger_id"
	belongs_to :nudgee, class_name: "User", foreign_key: "nudgee_id"
	belongs_to :event
end
