require 'rails_helper'

RSpec.describe WelcomeController do
  describe "GET #index" do
    before { get :index }

    context "when user is not logged in" do
      specify { expect(response).to have_http_status(:found) }
      specify { expect(response).to redirect_to(login_path) }
    end

    #context "when user is not verified" do
    #  let(:user) { create(:user) }
    #  before { sign_in(user) }
    #  specify { expect(response).to have_http_status(:found) }
    #end
  end
end
