require 'rails_helper'

RSpec.describe Student, type: :model do
  it "is invalid with no username" do
    expect(build(:student, username: "")).not_to be_valid
  end

  it "is invalid with no school ID" do
    expect(build(:student, school_id: nil)).not_to be_valid
  end

  it "is invalid with non-unique username" do
    create(:student, username: "username")
    expect(build(:student, username: "username")).not_to be_valid
  end

  describe "::nudgeable" do
    let!(:event) { create(:event) }
    let!(:student1) { create(:verified_student) }
    let!(:student2) { create(:verified_student) }
    let!(:student3) { create(:verified_student) }
    let!(:student4) { create(:verified_student, nudges_enabled: false) }
    let!(:student5) { create(:verified_student) }

    before { create(:attendance, student_id: student5.id, event_id: event.id) }

    it "does not return the nudger" do
      expect(Student.nudgeable(student1, event)).not_to include(student1)
    end

    it "does not return students with nudges disabled" do
      expect(Student.nudgeable(student1, event)).not_to include(student4)
    end

    it "does not return students who are already attending the event" do
      expect(Student.nudgeable(student1, event)).not_to include(student5)
    end

    it "returns all other students" do
      expect(Student.nudgeable(student1, event)).to eq([student2, student3])
    end
  end
end
