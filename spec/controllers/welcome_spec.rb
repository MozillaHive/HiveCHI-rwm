require 'rails_helper'

RSpec.describe WelcomeController do
  describe "GET #index" do
    context "when user is not logged in" do
      before { get :index }
      specify { expect(response).to have_http_status(:found) }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when user is logged in but not verified" do
      let(:user) { create(:user) }
      before { get :index, nil, { user_id: user.id } }
      specify { expect(response).to have_http_status(:found) }
      specify { expect(response).to redirect_to(dashboard_path) }
    end

    context "when user is logged in and verified" do
      let(:user) { create(:user, email_verified: true, phone_verified: true) }
      before { get :index, nil, { user_id: user.id } }
      specify { expect(response).to have_http_status(:found) }
      specify { expect(response).to redirect_to(dashboard_path) }
    end
  end

  describe "GET #dashboard" do
    describe "when user is not logged in" do
      before { get :dashboard }
      specify { expect(response).to have_http_status(:found) }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when user is logged in but not verified" do
      let(:user) { create(:user, phone_verified: false) }
      before { get :dashboard, nil, { user_id: user.id } }
      specify { expect(response).to have_http_status(:found) }
      specify { expect(response).to redirect_to(users_verify_path) }
    end

    context "when user is logged in and verified" do
      let(:user) { create(:user, email_verified: true, phone_verified: true) }
      before { get :dashboard, nil, { user_id: user.id } }
      specify { expect(user.verified?).to be true }
      specify { expect(response).to have_http_status(:ok) }
      specify { expect(response).to render_template("dashboard") }
    end
  end
end
