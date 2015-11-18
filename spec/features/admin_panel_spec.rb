require 'rails_helper'

RSpec.feature "User attempts to access admin panel", js: true do
  scenario "when not logged in" do
    visit rails_admin_path
    expect(page).not_to have_content("Site Administration")
  end

  scenario "as student" do
    log_in_as_student
    visit rails_admin_path
    expect(page).not_to have_content("Site Administration")
  end

  scenario "as service provider" do
    log_in_as_service_provider
    visit rails_admin_path
    expect(page).not_to have_content("Site Administration")
  end

  scenario "as admin" do
    log_in_as_admin
    visit rails_admin_path
    expect(page).to have_content("Site Administration")
  end
end
