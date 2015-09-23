require 'rails_helper'

RSpec.describe Nudge, type: :model do
  context "when validated" do
    let(:student_with_nudges_disabled) { create(:student, nudges_enabled: false) }
    
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
      expect(build(:nudge, nudgee: student_with_nudges_disabled)).not_to be_valid
    end
    it "is invalid with no event" do
      expect(build(:nudge, event: nil)).not_to be_valid
    end
  end
end
