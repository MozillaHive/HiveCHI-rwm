require 'rails_helper'

RSpec.describe ServiceProvider, type: :model do
  let(:organization) { create(:organization) }
  let(:user) { build(:user, email: "example@" + organization.domain_name) }

  context "validations" do
    subject { build(:service_provider) }

    it "is valid when email matches an organization's domain" do
      user = build(:user, email: "example@" + organization.domain_name)
      expect(build(:service_provider, user: user)).to be_valid
    end

    it "is invalid when email doesn't match an organization's domain" do
      user = build(:user, email: "example@nonexistent.com")
      expect(build(:service_provider, user: user)).not_to be_valid
    end
  end

  context "associations" do
    it { is_expected.to accept_nested_attributes_for(:user) }
    it { is_expected.to have_one(:user) }
    it { is_expected.to belong_to(:organization) }
  end

  context "on create" do
    it "automatically populates the organization ID based on email address" do
      sp = create(:service_provider, user: user)
      expect(sp.organization_id).to eq(organization.id)
    end
  end
end
