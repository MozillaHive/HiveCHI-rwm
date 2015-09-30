require 'rails_helper'

RSpec.describe Organization, type: :model do
  context "validations" do
    subject { build(:organization) }
    it { is_expected.to validate_presence_of(:name) }
  end

  context "associations" do
    subject { build(:organization) }
    it { is_expected.to have_many(:service_providers) }
    it { is_expected.to have_many(:events) }
  end
end
