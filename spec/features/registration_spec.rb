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

  context "as service provider" do
    scenario "with valid information" do
      register_as_service_provider
      expect(page).to have_content("Your email address has not been verified")
      expect(page).to have_button("Verify")
      expect(page).not_to have_content("Events")
    end

    scenario "with invalid information" do
      visit register_path
      click_link "Service Provider"
      click_button "Submit"
      click_link "Service Provider"
      expect(page).to have_content("error")
      expect(page).to have_button("Submit")
      expect(page).not_to have_button("Verify")
    end
  end
end

RSpec.feature "User verifies email and phone" do
  context "as student" do
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
end
