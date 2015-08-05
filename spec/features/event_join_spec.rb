require 'rails_helper'

RSpec.feature 'User interacts with an event', js: true do
  before { @event = create(:event) }

  context "When user is not logged in" do
    scenario "user visits events page" do
      visit event_path(@event)
      expect(page).not_to have_button("Join")
      expect(page).not_to have_button("Watch")
      expect(page).not_to have_button("Back Out")
      expect(page).not_to have_content("Number attending from your school")
      expect(page).to have_button("Log in")
    end
  end

  context "When user is logged in" do
    before { log_in }

    scenario "user visits events page" do
      visit event_path(@event)
      expect(page).to have_button("Join")
      expect(page).to have_button("Watch")
      expect(page).not_to have_button("Back Out")
      expect(page).to have_content("Number attending from your school")
      expect(page).not_to have_button("Log in")
    end

    scenario "user joins an event" do
      visit event_path(@event)
      click_button "Join"
      expect(page).not_to have_button("Join")
      expect(page).to have_button("Back Out")
      expect(page).to have_content("You are going to this event")
    end
  end
end
