require 'rails_helper'

RSpec.feature "Visitor signs up", js: true do
  context "as student" do
    let(:student) { build(:student) }

    scenario "With valid information" do
      register_as_student(student)
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

  context "as parent" do
    let(:parent) { build(:parent) }

    scenario "With valid information" do
      register_as_parent
      expect(page).to have_content("Your email address has not been verified")
      expect(page).to have_button("Verify")
      expect(page).not_to have_content("Dashboard")
    end

    scenario "With invalid information" do
      visit register_path
      click_link "Parent"
      click_button "Submit"
      click_link "Parent"
      expect(page).to have_content("error")
      expect(page).to have_button("Submit")
      expect(page).not_to have_button("Verify")
    end
  end
end

RSpec.feature "Visitor verifies email and phone" do
  let(:student) { create(:student) }

  scenario "User verifies email only" do
    visit "/users/verify-email?token=#{student.user.email_token}"
    expect(page).not_to have_content("Your email address has not been verified")
    expect(page).to have_button("Verify")
    expect(page).not_to have_content("Dashboard")
  end

  scenario "User verifies phone only" do
    log_in_as_student(student)
    fill_in "phone_token", with: student.user.phone_token
    click_button "Verify"
    expect(page).to have_content("Your email address has not been verified")
    expect(page).not_to have_button("Verify")
    expect(page).not_to have_content("Dashboard")
  end

  scenario "User verifies email and phone" do
    visit "/users/verify-email?token=#{student.user.email_token}"
    fill_in "phone_token", with: student.user.phone_token
    click_button "Verify"
    expect(page).not_to have_content("Your email address has not been verified")
    expect(page).not_to have_button("Verify")
    expect(page).to have_content("Dashboard")
  end
end
