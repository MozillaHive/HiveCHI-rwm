require 'rails_helper'

RSpec.describe UsersController do
  before(:all) do
    if ENV['PHONE_VERIFICATION'] == 'DISABLED' || ENV['EMAIL_VERIFICATION'] == 'DISABLED'
      warn "WARNING: UsersController specs will not run properly if email or " \
           "phone verification is disabled."
    end
  end

  describe "GET #new" do
    before { get :new }
    specify { expect(response).to render_template("new") }
  end

  describe "GET #verification" do
    context "with no logged in user" do
      before { get :verification }
      specify { expect(response).to redirect_to(login_path) }
    end
    context "with unverified user" do
      let(:user) { create(:user) }
      before { get :verification, nil, { user_id: user.id} }
      specify { expect(response).to render_template("verification") }
    end
    context "with verified user" do
      let(:user) { create(:verified_student).user }
      before { get :verification, nil, { user_id: user.id} }
      specify { expect(response).to redirect_to(dashboard_path) }
    end
  end

  describe "GET #verify_email" do
    let(:user) { create(:student).user }
    context "with correct token" do
      before { get :verify_email, { token: user.email_token } }
      specify { expect(response).to redirect_to(users_verify_path) }
      specify { expect(session[:user_id]).to eq(user.id) }
      specify { expect(user.reload.email_verified).to be true }
    end
    context "with incorrect token" do
      before { get :verify_email, token: SecureRandom.hex(10) }
      specify { expect(response).to redirect_to(root_path) }
      specify { expect(session[:user_id]).to be_nil }
    end
  end

  describe "POST #verify" do
    let(:user) { create(:user) }
    context "with correct phone token when email is verified" do
      before do
        get :verify_email, { token: user.email_token }
        post :verify, { phone_token: user.phone_token }, { user_id: user.id }
      end
      specify { expect(response).to redirect_to(dashboard_path) }
      specify { expect(user.reload.verified?).to be true }
    end
    context "with correct phone token when email is not verified" do
      before do
        post :verify, { phone_token: user.phone_token }, { user_id: user.id }
      end
      specify { expect(response).to render_template("verification") }
      specify { expect(user.reload.phone_verified).to be true }
    end
    context "with incorrect phone token" do
      before do
        post :verify, { phone_token: SecureRandom.hex(4) }, { user_id: user.id }
      end
      specify { expect(response).to render_template("verification") }
      specify { expect(user.reload.phone_verified).to be false }
    end
  end

end
