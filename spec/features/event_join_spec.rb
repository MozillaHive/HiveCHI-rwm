require 'rails_helper'

# The test 'expect(page).to have_css("div.gm-style")' tests whether the map is
# rendering, since that div is created by the script.

RSpec.feature 'User interacts with an event', js: true do
  before { @event = create(:event) }

  context "When user is not logged in" do
    scenario "user visits events page" do
      visit event_path(@event)
      expect(page).not_to have_button("Join")
      expect(page).not_to have_button("Watch")
      expect(page).not_to have_button("Back Out")
      expect(page).not_to have_button("Nudge")
      expect(page).not_to have_content("Number attending from your school")
      # expect(page).to have_css("div.gm-style")
      expect(page).to have_button("Log in")
    end
  end

  context "When user is logged in" do
    before { log_in_as_student }

    scenario "user visits events page" do
      visit event_path(@event)
      expect(page).to have_button("Join")
      expect(page).to have_button("Watch")
      expect(page).to have_button("Nudge")
      expect(page).not_to have_button("Back Out")
      expect(page).to have_content(@event.name)
      expect(page).to have_content("Number attending from your school")
      # expect(page).to have_css("div.gm-style")
      expect(page).not_to have_button("Log in")
    end

    scenario "user watches an event" do
      visit event_path(@event)
      click_button "Watch"
      expect(page).to have_content("Dashboard")
      visit event_path(@event)
      expect(page).not_to have_button("Watch")
      expect(page).to have_button("Join")
      expect(page).to have_button("Nudge")
      expect(page).to have_content("You are watching this event")
    end

    scenario "user joins an event" do
      visit event_path(@event)
      click_button "Join"
      # expect(page).to have_css("div.gm-style")
      expect(page).to have_content("Choose your transportation option:")
      # ChromeDriver does not recognize JQuery Mobile radio buttons as clickable
      # because of their z-index. This is a workaround:
      execute_script("transitChange('transit')")
      expect(page.html).to have_content("Choose your departure time:")
      execute_script("timeChange(1)")
      click_button "Let's Go!"
      expect(page).to have_content("You signed up for #{@event.name}")
      expect(page).to have_content("Dashboard")
      visit event_path(@event)
      expect(page).not_to have_button("Join")
      expect(page).to have_button("Back Out")
      expect(page).to have_button("Nudge")
      expect(page).to have_content("You are going to this event")
    end
  end
end
