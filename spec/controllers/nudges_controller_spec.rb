require 'rails_helper'

RSpec.describe NudgesController do
  let(:nudger) { create(:verified_student) }
  let(:nudgee) { create(:verified_student) }
  let!(:event) { create(:event) }

  before { puts event.id }

  describe "GET #new" do
    context "when not logged in" do
      before { get :new, event_id: event.id }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when logged in" do
      before { get :new, { event_id: event.id }, user_id: nudger.user.id }
      specify { expect(response).to render_template('new') }
      specify { expect(assigns(:nudge)).to be_a_new(Nudge) }
      specify { expect(assigns(:nudge).nudger).to eq(nudger) }
      specify { expect(assigns(:nudge).event).to eq(event) }
    end
  end

  describe "POST #create" do
    context "with invalid information" do
      before do
        post :create,
        { event_id: event.id, nudge: { nudgee_id: nudger.id, event_id: event.id } },
        user_id: nudger.user.id
      end
      specify { expect(response).to render_template('new') }
      specify { expect(Nudge.count).to eq(0) }
    end

    context "with valid information" do
      before do
        post :create,
        { event_id: event.id, nudge: { nudgee_id: nudgee.id, event_id: event.id } },
        user_id: nudger.user.id
      end
      specify { expect(response).to redirect_to(dashboard_path) }
      specify { expect(Nudge.count).to eq(1) }
    end
  end

  describe "DELETE #destroy" do
    let!(:nudge) do
      create(:nudge, nudger_id: nudger.id, nudgee_id: nudgee.id, event_id: event.id)
    end

    context "when accepting" do
      before do
        delete :destroy, { id: nudge.id, accept: "true" }, user_id: nudgee.user.id
      end
      specify { expect(response).to redirect_to(new_event_attendance_path(event)) }
      specify { expect(Nudge.count).to eq(0) }
    end

    context "when declining" do
      before do
        delete :destroy, { id: nudge.id }, user_id: nudgee.user.id
      end
      specify { expect(response).to redirect_to(event_path(event)) }
      specify { expect(Nudge.count).to eq(0) }
    end
  end
end
