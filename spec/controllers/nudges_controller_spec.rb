require 'rails_helper'

RSpec.describe NudgesController do
  let(:nudger) { create(:verified_student) }
  let(:nudgee) { create(:verified_student) }
  let(:unauthorized_student) { create(:verified_student, can_nudge: false) }
  let!(:event) { create(:event) }

  describe "GET #new" do
    context "when not logged in" do
      before { get :new, event_id: event.id }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when logged in and can nudge" do
      before { get :new, { event_id: event.id }, user_id: nudger.user.id }
      specify { expect(response).to render_template('new') }
      specify { expect(assigns(:nudge)).to be_a_new(Nudge) }
      specify { expect(assigns(:nudge).nudger).to eq(nudger) }
      specify { expect(assigns(:nudge).event).to eq(event) }
    end

    context "when logged in and not authorized to send nudges" do
      before { get :new, { event_id: event.id }, user_id: unauthorized_student.user.id }
      specify { expect(response).to redirect_to(event_path(event)) }
      specify { expect(assigns(:nudge)).to be_nil }
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

    context "when student is not authorized to send nudges" do
      before do
        post :create,
        { event_id: event.id, nudge: { nudgee_id: nudgee.id, event_id: event.id } },
        user_id: unauthorized_student.user.id
      end
      specify { expect(response).to redirect_to(event_path(event)) }
      specify { expect(Nudge.count).to eq(0) }
    end
  end

  describe "DELETE #destroy" do
    let!(:nudge) do
      create(:nudge, nudger_id: nudger.id, nudgee_id: nudgee.id, event_id: event.id)
    end

    context "when accepting and attendance already exists" do
      before do
        create(:attendance, student_id: nudgee.id, event_id: event.id, commitment_status: "Yes")
        delete :destroy, { id: nudge.id, accept: "true" }, user_id: nudgee.user.id
      end
      specify { expect(response).to redirect_to(event_path(event)) }
      specify { expect(Nudge.count).to eq(0) }
    end

    context "when accepting and attendance does not exist" do
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
