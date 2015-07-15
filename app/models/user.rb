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

  before_save :require_phone_verification, :require_email_verification

  def verified?
    self.email_verified && self.phone_verified
  end

  def verify_email!(token)
    if token == self.email_token
      self.email_verified = true
    else
      self.errors.add(:base, "Email verification code is incorrect")
    end
  end

  def verify_phone!(token)
    if token == self.phone_token
      self.phone_verified = true
    else
      self.errors.add(:base, "Phone verification code is incorrect")
    end
  end

  private

  def require_phone_verification
    if self.phone_changed?
      self.phone_verified = false
      self.phone_token = SecureRandom.base64(4)
    end
  end

  def require_email_verification
    if self.email_changed?
      self.email_verified = false
      self.email_token = SecureRandom.base64(10)
      
      UserMailer.verification_email("/verify-email?token=#{self.email_token}").deliver_now
    end
  end

end
