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
    self.phone = "1" + self.phone unless self.phone[0] == "1"
    self.phone = "+" + self.phone
  end
  validates_presence_of :email, :username, :phone, :school_id
  validates_uniqueness_of :email, :username # :phone
  validates :email, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  }
  validates :password, length: { minimum: 10 }, allow_nil: true
  validates :phone, length: { is: 12 }

  before_save :require_phone_verification, :require_email_verification

  def verified?
    self.email_verified && self.phone_verified
  end

  def verify_email!(token)
    if token && token == self.email_token
      self.email_verified = true
      self.email_token = nil
      self.save
    else
      self.errors.add(:base, "Email verification code is incorrect")
    end
  end

  def verify_phone!(token)
    if token && token == self.phone_token
      self.phone_verified = true
      self.phone_token = nil
      self.save
    else
      self.errors.add(:base, "Phone verification code is incorrect")
    end
  end

  def send_verification_email
    url = "http://#{HOSTNAME}/users/verify-email?token=#{self.email_token}"
    UserMailer.verification_email(url, self).deliver_now
  end

  def send_verification_text
    client = Twilio::REST::Client.new(
      Rails.application.secrets.twilio_sid,
      Rails.application.secrets.twilio_auth_token
    )
    client.account.messages.create(
      from: "+18443117433",
      to: self.phone,
      body: "Your RideW/Me verification code is #{self.phone_token}"
    )
  end

  private

  def require_phone_verification
    if self.phone_changed? && !(new_record? && phone_verified)
      self.phone_verified = false
      self.phone_token = SecureRandom.hex(4)
      send_verification_text
    end
  end

  def require_email_verification
    if self.email_changed? && !(new_record? && email_verified)
      self.email_verified = false
      self.email_token = SecureRandom.hex(10)
      send_verification_email
    end
  end

end
