require 'rails_helper'

RSpec.describe User, type: :model do
  context "when validated" do
    it "is valid with valid information" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "is invalid with no email address" do
      user = build(:user, email: "")
      expect(user).not_to be_valid
    end
    it "is invalid with invalid email address" do
      user = build(:user, email: "invalid@email")
      expect(user).not_to be_valid
    end
    it "is invalid with no username" do
      user = build(:user, username: "")
      expect(user).not_to be_valid
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
    it "is invalid with no school ID" do
      user = build(:user, school_id: nil)
      expect(user).not_to be_valid
    end
    it "is invalid with phone number of wrong length" do
      user = build(:user, phone: "1234567")
      expect(user).not_to be_valid
      user = build(:user, phone: "12345678901")
      expect(user).not_to be_valid
    end
    it "ignores special characters in phone number" do
      user = build(:user, phone: "123-456-7890")
      expect(user).to be_valid
      user = build(:user, phone: "(123) 456-7890")
      expect(user).to be_valid
    end
    it "is invalid with non-unique phone number" do
      # not yet implemented
    end
    it "is invalid with non-unique username" do
      user1 = create(:user, username: "username1")
      user2 = build(:user, username: "username1")
      expect(user2).not_to be_valid
    end
    it "is invalid with non-unique email" do
      user1 = create(:user, email: "email1@something.com")
      user2 = build(:user, email: "email1@something.com")
      expect(user2).not_to be_valid
    end
  end

  context "after save" do
    it "automatically generates verification tokens" do
      user = create(:user)
      expect(user.phone_token).to be_a(String)
      expect(user.email_token).to be_a(String)
      expect(user.email_verified).to be false
      expect(user.phone_verified).to be false
      expect(user.verified?).to be false
    end
    it "verifies email and phone when tokens are provided and deletes tokens" do
      user = create(:user)
      user.verify_email!(user.email_token)
      user.verify_phone!(user.phone_token)
      expect(user.phone_token).to be_nil
      expect(user.email_token).to be_nil
      expect(user.email_verified).to be true
      expect(user.phone_verified).to be true
      expect(user.verified?).to be true
    end
  end
end
