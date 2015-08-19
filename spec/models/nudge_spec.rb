require 'rails_helper'

RSpec.describe Nudge, type: :model do
  context "when validated" do
    it "is valid with valid information" do
      expect(build(:nudge)).to be_valid
    end
    it "is invalid with no nudger" do
      expect(build(:nudge, nudger: nil)).not_to be_valid
    end
    it "is invalid with no nudgee" do
      expect(build(:nudge, nudgee: nil)).not_to be_valid
    end
    it "is invalid when nudgee has nudges disabled" do
      user = create(
        :user, nudges_enabled: false, email_verified: true, phone_verified: true
      )
      expect(build(:nudge, nudgee: user)).not_to be_valid
    end
    it "is invalid with no event" do
      expect(build(:nudge, event: nil)).not_to be_valid
    end
  end
end
