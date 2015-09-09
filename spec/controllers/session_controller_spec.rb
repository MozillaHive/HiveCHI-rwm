require 'rails_helper'

RSpec.describe SessionController do
  let(:user) do
    student = create(:student)
    student.user.update(phone_verified: true, email_verified: true)
    student.user
  end

  describe "GET #new" do
    before { get :login }
    specify { expect(response).to render_template("login") }
  end

  describe "POST #create" do
    context "with valid username and password" do
      before do
        post :create, user: { username: user.role.username, password: "password1234" }
      end
      specify { expect(response).to redirect_to(dashboard_path) }
      specify { expect(session[:user_id]).to eq(user.id) }
    end

    context "with invalid username" do
      before do
        post :create, user: { username: "doesntexist", password: "password1234" }
      end
      specify { expect(response).to render_template('login') }
      specify { expect(session[:user_id]).to be_nil }
    end

    context "with invalid password" do
     before do
       post :create, user: { username: user.role.username, password: "badpassword" }
     end
     specify { expect(response).to render_template('login') }
     specify { expect(session[:user_id]).to be_nil }
    end
  end

  describe "DELETE #destroy" do
    before do
      post :create, user: { username: user.role.username, password: "password1234" }
      delete :destroy
    end
    specify { expect(session[:user_id]).to be_nil }
  end
end
