require 'rails_helper'

RSpec.describe User, type: :model do
  context "when validated" do
    it "is valid with valid information" do
      expect(build(:user)).to be_valid
    end

    it "is invalid with no email address" do
      expect(build(:user, email: "")).not_to be_valid
    end

    it "is invalid with invalid email address" do
      expect(build(:user, email: "invalid@email")).not_to be_valid
    end
    it "is invalid with no phone number" do
      expect(build(:user, phone: "")).not_to be_valid
    end

    it "is invalid when password and password confirmation don't match" do
      user = build(:user, password: "hellohello",
                          password_confirmation: "hellogoodbye")
      expect(user).not_to be_valid
    end

    it "is invalid when password is less than 10 characters" do
      user = build(:user, password: "hellohell",
                          password_confirmation: "hellohell")
      expect(user).not_to be_valid
    end

    it "is invalid with phone number of wrong length" do
      expect(build(:user, phone: "2234567")).not_to be_valid
      expect(build(:user, phone: "22345678901")).not_to be_valid
    end

    it "ignores formatting of phone number" do
      expect(build(:user, phone: "223-456-7890")).to be_valid
      expect(build(:user, phone: "(223) 456-7890")).to be_valid
      expect(build(:user, phone: "1-223-456-7890")).to be_valid
    end

    it "is invalid with non-unique email" do
      create(:user, email: "email1@something.com")
      expect(build(:user, email: "email1@something.com")).not_to be_valid
    end
  end

  context "after save" do
    let(:user) { create(:user) }
    specify { expect(user.phone_token).not_to be_nil }
    specify { expect(user.email_token).not_to be_nil }
    specify { expect(user.email_verified).to be false }
    specify { expect(user.phone_verified).to be false }
    specify { expect(user.verified?).to be false }
    specify { expect(user.phone).to match(/\A\+1/) }
  end

  context "verify phone" do
    it 'sets phone_verified to true and saves when token exists and matches the user phone token' do
      user = create(:user)
      user.verify_phone!(user.phone_token)
      expect(user.phone_token).to be_nil
      expect(user.phone_verified).to be true
    end

    it 'sets an error when phone token validation fails' do
      user = create(:user)
      user.verify_phone!(nil)
      expect(user.phone_token).to_not be_nil
      expect(user.phone_verified).to be false
      expect(user.errors[:base]).to eq([I18n.t(:phone_verification_code_incorrect)])
    end
  end

  context "verify email" do
    it 'sets email_verified to true and saves when token exists and matches the user email token' do
      user = create(:user)
      user.verify_email!(user.email_token)
      expect(user.email_token).to be_nil
      expect(user.email_verified).to be true
    end

    it 'sets an error when email token validation fails' do
      user = create(:user)
      user.verify_email!(nil)
      expect(user.email_token).to_not be_nil
      expect(user.email_verified).to be false
      expect(user.errors[:base]).to eq([I18n.t(:email_verification_code_incorrect)])
    end
  end

  context "after email and phone are verified" do
    let(:user) do
      user = create(:user)
      user.verify_email!(user.email_token)
      user.verify_phone!(user.phone_token)
      user
    end
    specify { expect(user.phone_token).to be_nil }
    specify { expect(user.email_token).to be_nil }
    specify { expect(user.email_verified).to be true }
    specify { expect(user.phone_verified).to be true }
    specify { expect(user.verified?).to be true }
  end

  context 'send_verification_email' do
    it 'sends a verification email to the user' do
      user = build(:user, email_token: '1234')
      ENV['HOSTNAME'] = 'fake.com'
      expected_url = 'http://fake.com/users/verify-email?token=1234'
      expect_any_instance_of(UserMailer).to receive(:verification_email).with(expected_url, user)

      user.send_verification_email
    end
  end

  context 'send_verification_text' do
    # pending 'sends a verification text to the user' do
    #  user = build(:user, phone: '1234567890')
    #  ENV['HOSTNAME'] = 'fake.com'
    #  expected_url = 'http://fake.com/users/verify-email?token=1234'

    #  user.send_verification_email
  end
end
