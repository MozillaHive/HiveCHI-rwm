require 'rails_helper'

RSpec.describe Nudge, type: :model do
  context "when validated" do
    let(:student) { create(:verified_student) }
    let(:student_with_nudges_disabled) { create(:verified_student, nudges_enabled: false) }

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

    it "is invalid when nudger and nudgee are the same" do
      expect(build(:nudge, nudger: student, nudgee: student)).not_to be_valid
    end
  end

  describe "#accept!" do
    let(:nudger) { create(:verified_student) }
    let(:nudge) { create(:nudge, nudger: nudger) }

    before do
      allow(nudger).to receive(:send_text)
      nudge.accept!
    end

    it "destroys the nudge" do
      expect(Nudge.count).to eq(0)
    end

    it "sends the nudger a text" do
      expect(nudger).to have_received(:send_text)
    end
  end

  describe "#decline!" do
    let(:nudge) { create(:nudge) }

    it "destroys the nudge" do
      expect(Nudge.count).to eq(0)
    end
  end 
end
