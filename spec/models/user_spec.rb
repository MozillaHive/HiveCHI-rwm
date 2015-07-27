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
    it "is invalid with no username" do
      expect(build(:user, username: "")).not_to be_valid
    end
    it "is invalid with no phone number" do
      expect(build(:user, phone: "")).not_to be_valid
    end
    it "is invalid with no school ID" do
      expect(build(:user, school_id: nil)).not_to be_valid
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
    it "is invalid with non-unique phone number"
    it "is invalid with non-unique username" do
      create(:user, username: "username1")
      expect(build(:user, username: "username1")).not_to be_valid
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
end
