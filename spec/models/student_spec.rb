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
end
