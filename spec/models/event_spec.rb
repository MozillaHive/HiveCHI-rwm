require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event1 = create(:event, name: "event1", start_date_and_time: 1.day.ago)
    @event2 = create(:event, name: "event2", start_date_and_time: 1.hour.ago, duration: 3)
    @event3 = create(:event, name: "event3", start_date_and_time: 1.day.from_now.beginning_of_day)
    @event4 = create(:event, name: "event4", start_date_and_time: 1.day.from_now.at_midday)
    @event5 = create(:event, name: "event5", start_date_and_time: 5.days.from_now)
    @event6 = create(:event, name: "event6", start_date_and_time: 10.days.from_now)
    5.times { create(:attendance, event_id: @event1.id) }
    4.times { create(:attendance, event_id: @event5.id) }
    3.times { create(:attendance, event_id: @event3.id) }
    2.times { create(:attendance, event_id: @event4.id) }
  end

  describe "::popular_events" do
    it "finds the n most popular events that have not yet started" do
      expect(Event.popular_events(3)).to eq([@event5, @event3, @event4])
    end
  end

  describe "::by_time" do
    context "when only a start datetime is provided" do
      it "finds all events on that day" do
        expect(Event.by_time(Date.tomorrow, nil)).to eq([@event3, @event4])
      end
    end

    context "when both start and end datetimes are provided" do
      it "finds all events between those times" do
        events = Event.by_time(Date.tomorrow, Date.today + 7.days)
        expect(events).to eq([@event3, @event4, @event5])
      end
    end
  end

  describe "::future_events" do
    it "finds all events that have not ended yet" do
      expect(Event.future_events).to eq([@event2, @event3, @event4, @event5, @event6])
    end
  end
end
