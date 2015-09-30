require 'rails_helper'

RSpec.describe ServiceProvider, type: :model do
  subject { build(:service_provider) }
  it { is_expected.to validate_presence_of(:organization_id) }
  it { is_expected.to accept_nested_attributes_for(:user) }
end
