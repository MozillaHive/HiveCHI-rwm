require 'rails_helper'

RSpec.describe EventsController do
  let(:student) do
    student = create(:student)
    student.user.update(phone_verified: true, email_verified: true)
    student
  end

  describe "GET #index" do
    before do
      @event1 = create(:event, start_date_and_time: 1.day.ago)
      @event2 = create(:event, start_date_and_time: 1.day.from_now)
      @event3 = create(:event, start_date_and_time: 5.days.from_now)
      @event4 = create(:event, start_date_and_time: 10.days.from_now)
    end

    context "with no parameters" do
      #before { get :index }
      #specify { expect(assigns(:events).size).to eq(3) }
    end

    context "with start time parameter" do
      before { get :index, { start_time: "2015-09-30 00:00:00 -0500" }, user_id: student.user.id }
      specify { expect(response).to render_template('index') }
      specify { expect(assigns(:events)).to eq(@event2) }
      specify { expect(assigns(:events)).to include(@event2) }
    end
  end
end
