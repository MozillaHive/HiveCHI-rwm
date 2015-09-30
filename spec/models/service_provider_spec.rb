require 'rails_helper'

RSpec.describe ServiceProvider, type: :model do
  context "validations" do
    subject { build(:service_provider) }
    it { is_expected.to validate_presence_of(:organization_id) }
  end

  context "associations" do
    it { is_expected.to accept_nested_attributes_for(:user) }
    it { is_expected.to have_one(:user) }
    it { is_expected.to belong_to(:organization) }
  end
end
