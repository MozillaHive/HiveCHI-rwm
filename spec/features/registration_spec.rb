require 'rails_helper'

RSpec.feature "Visitor signs up" do
  let(:user) { build(:user) }
  before { @school = create(:school) }

  scenario "With valid information" do
    register(user, @school)
    expect(page).to have_content("Your email address has not been verified")
    expect(page).to have_button("Verify")
    expect(page).not_to have_content("Dashboard")
  end

  scenario "With invalid information" do
    visit register_path
    click_button "Create User"
    expect(page).to have_content("error")
    expect(page).to have_button("Create User")
    expect(page).not_to have_button("Verify")
  end
end
