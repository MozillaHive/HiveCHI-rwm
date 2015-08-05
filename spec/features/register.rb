require 'rails_helper'

RSpec.feature "Visitor signs up" do
  let(:user) { build(:user) }
  before { @school = create(:school) }

  scenario "With valid information" do
    visit register_path
    fill_in "Username", with: user.username
    fill_in "Email", with: user.email
    fill_in "Phone", with: user.phone
    select @school.name, from: "user_school_id"
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password_confirmation
    fill_in "Parent password", with: user.parent_password
    fill_in "Parent password confirmation", with: user.parent_password_confirmation
    click_button "Create User"
    expect(page).to have_content("Your email address has not been verified")
    expect(page).to have_button("Verify")
    expect(page).not_to have_content("Dashboard")
  end
end
