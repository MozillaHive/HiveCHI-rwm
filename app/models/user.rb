class User < ActiveRecord::Base
  has_secure_password
  belongs_to :school
  has_many :attendances
  has_many :events_attended, through: :attendances, source: :event
  has_many :sent_nudges, class_name: "Nudge", foreign_key: :nudger_id
  has_many :recieved_nudges, class_name: "Nudge", foreign_key: :nudgee_id
  # TODO: TOS acceptance, password strength checks
  before_validation do
    self.phone = self.phone.gsub(/[^\d]/, '') unless self.phone.blank?
  end
  validates_presence_of :email, :username, :phone, :school_id
  validates_uniqueness_of :email, :username # :phone
  validates :email, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  }
  validates :password, length: { minimum: 10 }, allow_nil: true
  validates :phone, length: { is: 10 }

  def email_verified?
    #placeholder
  end

  def phone_verified?
    #placeholder
  end

  def verified?
    self.email_verified? && self.phone_verified?
  end

  def verify_email!(token)
  end

  def verify_phone!(token)
  end

end
