require 'rails_helper'

RSpec.feature 'User joins an event', js: true do
  before { create(:event) }

  scenario "User visits event page when not logged in" do
    puts Event.all.count
    visit event_path(Event.first)
    expect(page).not_to have_button("Join")
    expect(page).not_to have_button("Watch")
    expect(page).not_to have_button("Back Out")
    expect(page).not_to have_content("Number attending from your school")
    expect(page).to have_button("Log in")
  end
end
