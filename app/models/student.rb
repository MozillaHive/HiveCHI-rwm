class Student < ActiveRecord::Base
  has_one :user, as: :role, dependent: :destroy
  accepts_nested_attributes_for :user
  belongs_to :school

  has_many :attendances, dependent: :destroy
  has_many :events_attended, through: :attendances, source: :event
  has_many :sent_nudges, class_name: "Nudge", foreign_key: :nudger_id, dependent: :destroy
  has_many :recieved_nudges, class_name: "Nudge", foreign_key: :nudgee_id, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :school_id, presence: true

  def self.nudgeable(nudger, event)
    where(nudges_enabled: true)
      .where.not(id: nudger.id)
      .where('id NOT IN (SELECT student_id FROM attendances WHERE commitment_status = \'Yes\' AND event_id = ?)', event.id)
  end

  def send_text(body)
    user.send_text(body)
  end
end
