require 'rails_helper'

RSpec.feature "Service provider interacts with an event", js: true do
  before { log_in_as_service_provider }

  context "When creating an event" do
    let(:event) { build(:event) }

    scenario "with invalid information" do
      visit new_service_provider_event_path
      click_button "Submit"
      expect(page).to have_content("Create an Event")
      expect(page).to have_content("error")
      expect(page).not_to have_content("Attendee breakdown")
    end

    scenario "with valid information" do
      visit new_service_provider_event_path
      fill_in "Name", with: event.name
      fill_in "Address", with: event.address
      select event.start_date_and_time.year, from: "event_start_date_and_time_1i"
      select event.start_date_and_time.strftime('%B'), from: "event_start_date_and_time_2i"
      select event.start_date_and_time.day, from: "event_start_date_and_time_3i"
      select event.start_date_and_time.strftime('%l:%M %p'), from: "event_start_date_and_time_5i"
      select event.duration, from: "event_duration"
      #select event.event_type, from: "event_event_type"
      fill_in "Description", with: event.description
      click_button "Submit"
      expect(page).not_to have_content("error")
      expect(page).not_to have_content("Create an Event")
      expect(page).to have_content("Event: " + event.name)
      expect(page).to have_content(event.description)
      visit service_provider_root_path
      expect(page).to have_content(event.name)
    end
  end

  context "When editing an event" do
    let!(:service_provider) { create(:verified_service_provider) }
    let!(:event) { create(:event, organization_id: service_provider.organization_id) }
    before do
      reset_session!
      log_in_as_service_provider(service_provider)
    end

    scenario "with invalid information" do
      visit edit_service_provider_event_path(event)
      save_screenshot
      fill_in "Name", with: ""
      click_button "Submit"
      expect(page).to have_content("error")
      expect(page).to have_content("Edit Event: " + event.name)
      expect(page).not_to have_content("Attendee breakdown")
      visit service_provider_event_path(event)
      expect(page).to have_content(event.name)
    end

    scenario "with valid information" do
      visit edit_service_provider_event_path(event)
      fill_in "Name", with: "New Name"
      click_button "Submit"
      expect(page).not_to have_content("error")
      expect(page).not_to have_content("Edit Event: #{event.name}")
      expect(page).to have_content("New Name")
      expect(page).to have_content("Attendee breakdown")
      visit service_provider_root_path
      expect(page).to have_content("New Name")
    end
  end
end
