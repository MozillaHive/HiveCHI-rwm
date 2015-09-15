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
    click_button "Submit"
    expect(page).to have_content("error")
    expect(page).to have_button("Submit")
    expect(page).not_to have_button("Verify")
  end
end

RSpec.feature "Visitor verifies email and phone" do
  let(:user) { create(:user) }

  scenario "User verifies email only" do
    visit "/users/verify-email?token=#{user.email_token}"
    expect(page).not_to have_content("Your email address has not been verified")
    expect(page).to have_button("Verify")
    expect(page).not_to have_content("Dashboard")
  end

  scenario "User verifies phone only" do
    log_in_as_student(user)
    fill_in "phone_token", with: user.phone_token
    click_button "Verify"
    expect(page).to have_content("Your email address has not been verified")
    expect(page).not_to have_button("Verify")
    expect(page).not_to have_content("Dashboard")
  end

  scenario "User verifies email and phone" do
    visit "/users/verify-email?token=#{user.email_token}"
    fill_in "phone_token", with: user.phone_token
    click_button "Verify"
    expect(page).not_to have_content("Your email address has not been verified")
    expect(page).not_to have_button("Verify")
    expect(page).to have_content("Dashboard")
  end
end
