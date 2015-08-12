class User < ActiveRecord::Base
  @@email_format = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password
  belongs_to :school
  has_many :attendances, dependent: :destroy
  has_many :events_attended, through: :attendances, source: :event
  has_many :sent_nudges, class_name: "Nudge", foreign_key: :nudger_id, dependent: :destroy
  has_many :recieved_nudges, class_name: "Nudge", foreign_key: :nudgee_id, dependent: :destroy
  # TODO: TOS acceptance, password strength checks
  before_validation do
    self.phone = self.phone.gsub(/[^\d]/, '') unless self.phone.blank?
    self.phone = "1" + self.phone unless self.phone[0] == "1"
    self.phone = "+" + self.phone
  end
  validates_presence_of :email, :username, :phone, :school_id
  validates_uniqueness_of :email, :username # :phone
  validates :email, format: { with: @@email_format }
  validates :username, format: { without: @@email_format }
  validates :password, length: { minimum: 10 }, allow_blank: true
  validates :parent_password, length: { minimum: 10 }, allow_blank: true, confirmation: true
  validates :phone, length: { is: 12 }
  validate :no_password_collision?, :real_phone_number?
  before_save :require_phone_verification, :require_email_verification, :hash_parent_pass

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
    url = "http://#{ENV["HOSTNAME"]}/users/verify-email?token=#{self.email_token}"
    UserMailer.verification_email(url, self).deliver_now
  end

  def send_verification_text
    client = Twilio::REST::Client.new(
      Rails.application.secrets.twilio_sid,
      Rails.application.secrets.twilio_auth_token
    )
    client.account.messages.create(
      from: Rails.application.secrets.twilio_originating_number,
      to: self.phone,
      body: "Your RideW/Me verification code is #{self.phone_token}"
    )
  end

  def hash_parent_pass
    if attribute_present?(:parent_password) && !BCrypt::Password.valid_hash?(self.parent_password)
      self.parent_password = BCrypt::Password.create(self.parent_password)
    end
  end

  #This is simple password collision detection that will need changing when we add the ability to change passwords
  def no_password_collision?
    if attribute_present?(:parent_password) && self.parent_password == self.password
      errors.add(:parent_password, "and password must be different")
    end
  end

  def reset_password!
    self.update(inactive: true, password_reset_token: SecureRandom.hex(10))
    url = "http://#{ENV['HOSTNAME']}/password_reset/edit?token=#{self.password_reset_token}"
    UserMailer.password_reset_email(url, self).deliver_now
  end

  private

  def real_phone_number?
    return
    unless new_record? && phone_verified
      client = Twilio::REST::LookupsClient.new(
        ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
      )
      number = client.phone_numbers.get(self.phone)
      begin
        number.carrier
      rescue
        errors.add(:phone, "number is invalid")
      end
    end
  end

  def require_phone_verification
    if ENV['PHONE_VERIFICATION'] == 'DISABLED'
      self.phone_verified = true
    elsif self.phone_changed? && !(new_record? && phone_verified)
      self.phone_verified = false
      self.phone_token = SecureRandom.hex(4)
      send_verification_text
    end
  end

  def require_email_verification
    if ENV['EMAIL_VERIFICATION'] == 'DISABLED'
      self.email_verified = true
    elsif self.email_changed? && !(new_record? && email_verified)
      self.email_verified = false
      self.email_token = SecureRandom.hex(10)
      send_verification_email
    end
  end

end
