require 'rails_helper'

RSpec.describe Parent, type: :model do
  it "is invalid without a user" do
    expect(build(:parent, user_attributes: {})).not_to be_valid
  end
end
