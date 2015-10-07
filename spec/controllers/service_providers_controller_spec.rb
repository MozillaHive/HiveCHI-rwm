require 'rails_helper'

RSpec.describe ServiceProvidersController, type: :controller do
  let(:service_provider) { create(:verified_service_provider) }

  describe "POST #create" do
    context "with valid attributes" do
      before { post :create, service_provider: FactoryGirl.attributes_for(:service_provider) }
      specify { expect(response).to redirect_to(users_verify_path) }
      specify { expect(ServiceProvider.count).to eq(1) }
      specify { expect(User.count).to eq(1) }
      specify { expect(session[:user_id]).not_to be_nil }
    end

    context "with invalid attributes" do
      before do
        post :create, service_provider: FactoryGirl.attributes_for(:service_provider)
          .merge(user_attributes: FactoryGirl.attributes_for(:user).merge(email: "invalid@email") )
      end
      specify { expect(response).to render_template("new") }
      specify { expect(ServiceProvider.count).to eq(0) }
      specify { expect(User.count).to eq(0) }
      specify { expect(session[:user_id]).to be_nil }
    end
  end

  describe "GET #edit" do
    before { get :edit, nil, user_id: service_provider.user.id }
    specify { expect(response).to render_template("edit") }
    specify { expect(assigns(:service_provider)).to eq(service_provider) }
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before do
        patch :update, { service_provider: { user_attributes: { email: "a@b.com", id: service_provider.user.id } } },
          user_id: service_provider.user.id
      end
      specify { expect(response).to redirect_to(service_provider_root_path) }
      specify { expect(service_provider.user.reload.email).to eq("a@b.com") }
    end

    context "with invalid attributes" do
      before do
        patch :update, { service_provider: { user_attributes: { email: "invalid", id: service_provider.user.id } } },
          user_id: service_provider.user.id
      end
      specify { expect(response).to render_template("edit") }
      specify { expect(service_provider.user.reload.email).not_to eq("invalid") }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, nil, user_id: service_provider.user.id }
    specify { expect(ServiceProvider.count).to eq(0) }
    specify { expect(User.count).to eq(0) }
    specify { expect(session[:user_id]).to be_nil }
  end
end
