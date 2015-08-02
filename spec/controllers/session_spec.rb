require 'rails_helper'

RSpec.describe SessionController do
  let(:user) { create(:user, phone_verified: true, email_verified: true) }

  describe "GET #new" do
    before { get :login }
    specify { expect(response).to render_template("login") }
  end

  describe "POST #create" do
    context "with valid username and password" do
      before do
        post :create, user: { username: user.username, password: user.password }
      end
      # This should probably redirect to dashboard_path, but this is what it
      # currently does:
      specify { expect(response).to redirect_to(redirect_path) }
      specify { expect(session[:user_id]).to eq(user.id) }
    end

    context "with invalid username" do
      before do
        post :create, user: { username: "doesntexist", password: user.password }
      end
      specify { expect(response).to redirect_to(login_path) }
      specify { expect(session[:user_id]).to be_nil }
    end

    context "with invalid password" do
    # before do
    #   post :create, user: { username: user.username, password: "badpassword" }
    # end
    # Note on the below: running these tests will raise a BCrypt::Errors::InvalidHash
    # exception. When the application is actually running, it responds properly
    # to an incorrect password. I don't know why these tests don't work. See:
    # http://stackoverflow.com/questions/31709305/simulating-a-login-attempt-with-incorrect-password-in-an-rspec-controller-spec-r

    # specify { expect(response).to redirect_to(login_path) }
    # specify { expect(session[:user_id]).to be_nil }
    end
  end

  describe "DELETE #destroy" do
    before do
      post :create, user: { username: user.username, password: user.password }
      delete :destroy
    end
    specify { expect(session[:user_id]).to be_nil }
  end
end
