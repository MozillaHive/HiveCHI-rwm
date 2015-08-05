require 'rails_helper'

RSpec.feature 'User joins an event', js: true do
  before { @event = create(:event) }

  scenario "User visits event page when not logged in" do
    visit event_path(@event)
    expect(page).not_to have_button("Join")
    expect(page).not_to have_button("Watch")
    expect(page).not_to have_button("Back Out")
    expect(page).not_to have_content("Number attending from your school")
    expect(page).to have_button("Log in")
  end

  scenario "User visits event page when logged in" do
    log_in
    visit event_path(@event)
    expect(page).to have_button("Join")
    expect(page).to have_button("Watch")
    expect(page).not_to have_button("Back Out")
    expect(page).to have_content("Number attending from your school")
    expect(page).not_to have_button("Log in")
  end
end
