require 'rails_helper'

RSpec.describe SessionController do
  let(:student) { create(:verified_student) }
  let(:service_provider) { create(:verified_service_provider) }

  describe "GET #new" do
    before { get :login }
    specify { expect(response).to render_template("login") }
  end

  describe "POST #create" do
    context "as student" do
      context "with valid username and password" do
        before do
          post :create, session: { username: student.username, password: "password1234" }
        end
        specify { expect(response).to redirect_to(dashboard_path) }
        specify { expect(session[:user_id]).to eq(student.user.id) }
      end

      context "with invalid username" do
        before do
          post :create, session: { username: "doesntexist", password: "password1234" }
        end
        specify { expect(response).to render_template('login') }
        specify { expect(session[:user_id]).to be_nil }
      end

      context "with invalid password" do
        before do
          post :create, session: { username: student.username, password: "badpassword" }
        end
        specify { expect(response).to render_template('login') }
        specify { expect(session[:user_id]).to be_nil }
      end
    end

    context "as service provider" do
      context "with valid username and password" do
        before do
          post :create, session: { username: service_provider.user.email, password: "password1234" }
        end
        specify { expect(response).to redirect_to(service_provider_root_path) }
        specify { expect(session[:user_id]).to eq(service_provider.user.id) }
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      post :create, session: { username: student.username, password: "password1234" }
      delete :destroy
    end
    specify { expect(session[:user_id]).to be_nil }
  end
end
