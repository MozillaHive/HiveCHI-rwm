require 'rails_helper'

RSpec.describe EventsController do
  let(:student) do
    student = create(:student)
    student.user.update(phone_verified: true, email_verified: true)
    student
  end
  let(:event) { create(:event) }

  describe "GET #index" do
    before do
      @event1 = create(:event, start_date_and_time: 1.day.ago)
      @event2 = create(:event, start_date_and_time: 1.day.from_now)
      @event3 = create(:event, start_date_and_time: 5.days.from_now)
      @event4 = create(:event, start_date_and_time: 10.days.from_now)
    end

    context "when not logged in" do
      before { get :index }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "with no parameters" do
      before { get :index, nil, user_id: student.user.id }
      specify { expect(response).to render_template('index') }
      specify { expect(assigns(:events)).to eq([@event2, @event3, @event4]) }
    end

    context "with start time parameter only" do
      before do
        get :index, { start_time: Date.tomorrow.beginning_of_day },
            user_id: student.user.id
      end
      specify { expect(response).to render_template('index') }
      specify { expect(assigns(:events)).to eq([@event2]) }
    end

    context "with start and end time parameters" do
      before do
        get :index, { start_time: Date.today.beginning_of_day,
            end_time: Date.today.beginning_of_day + 7.days },
            user_id: student.user.id
      end
      specify { expect(response).to render_template('index') }
      specify { expect(assigns(:events)).to eq([@event2, @event3]) }
    end
  end

  describe "GET #show" do
    context "when logged in" do
      before { get :show, { id: event.id }, user_id: student.user.id }
      specify { expect(response).to render_template('show') }
      specify { expect(assigns(:event)).to eq(event) }
    end

    context "when not logged in" do
      before { get :show, { id: event.id } }
      specify { expect(response).to render_template('show') }
      specify { expect(assigns(:event)).to eq(event) }
    end
  end
end
