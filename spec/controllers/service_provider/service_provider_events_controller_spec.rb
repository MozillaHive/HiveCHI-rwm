require 'rails_helper'
require 'service_provider/events_controller'

RSpec.describe ServiceProvider::EventsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:event) { create(:event, organization_id: organization.id) }
  let(:user_attributes) { attributes_for(:verified_user, email: SecureRandom.hex(5) + organization.domain_name) }
  let(:service_provider) { create(:service_provider, user_attributes: user_attributes) }
  let(:service_provider_2) { create(:verified_service_provider) }

  describe "GET #index" do
    context "when not logged in" do
      before { get :index }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when logged in" do
      before { get :index, nil, user_id: service_provider.user.id }
      specify { expect(response).to render_template("index") }
      specify { expect(assigns(:events)).to eq([event]) }
    end
  end

  describe "GET #show" do
    context "when not logged in" do
      before { get :show, id: event.id }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when logged in and resource is not owned" do
      before { get :show, { id: event.id }, user_id: service_provider_2.user.id }
      specify { expect(response).to redirect_to(service_provider_root_path) }
    end

    context "when logged in and resource is owned" do
      before { get :show, { id: event.id }, user_id: service_provider.user.id }
      specify { expect(response).to render_template("show") }
      specify { expect(assigns(:event)).to eq(event) }
    end
  end

  describe "GET #new" do
    context "when not logged in" do
      before { get :new }
      specify { expect(response).to redirect_to(login_path) }
    end

    context "when logged in" do
      before { get :new, nil, user_id: service_provider.user.id }
      specify { expect(response).to render_template("new") }
      specify { expect(assigns(:event)).to be_a_new(Event) }
      specify { expect(assigns(:event).organization_id).to eq(organization.id) }
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before { post :create, { event: FactoryGirl.attributes_for(:event) }, user_id: service_provider.user.id }
      specify { expect(response).to redirect_to(service_provider_event_path(assigns(:event).id)) }
      specify { expect(Event.count).to eq(2) }
    end

    context "with invalid attributes" do
      before do
        post :create, { event: FactoryGirl.attributes_for(:event).merge(name: "") }, user_id: service_provider.user.id
      end
      specify { expect(response).to render_template("new") }
      specify { expect(Event.count).to eq(1) }
    end
  end

  describe "GET #edit" do
    context "when resource is not owned" do
      before { get :edit, { id: event.id }, user_id: service_provider_2.user.id }
      specify { expect(response).to redirect_to(service_provider_root_path) }
    end

    context "when resource is owned" do
      before { get :edit, { id: event.id }, user_id: service_provider.user.id }
      specify { expect(response).to render_template("edit") }
      specify { expect(assigns(:event)).to eq(event) }
    end
  end

  describe "PATCH #update" do
    context "when resource is not owned" do
      before { patch :update, { id: event.id, event: { name: "New Name"} }, user_id: service_provider_2.user.id }
      specify { expect(response).to redirect_to(service_provider_root_path) }
      specify { expect(event.name).not_to eq("New Name") }
    end

    context "when resource is owned" do
      context "with valid attributes" do
        before { patch :update, { id: event.id, event: { name: "New Name"} }, user_id: service_provider.user.id }
        specify { expect(response).to redirect_to(service_provider_event_path(event)) }
        specify { expect(event.reload.name).to eq("New Name") }
      end

      context "with invalid attributes" do
        before { patch :update, { id: event.id, event: { name: ""} }, user_id: service_provider.user.id }
        specify { expect(response).to render_template("edit") }
        specify { expect(event.reload.name).not_to eq("") }
      end
    end
  end

  describe "DELETE #destroy" do
    context "when resource is not owned" do
      before { delete :destroy, { id: event.id }, user_id: service_provider_2.user.id }
      specify { expect(response).to redirect_to(service_provider_root_path) }
      specify { expect(Event.count).to eq(1) }
    end

    context "when resource is owned" do
      before { delete :destroy, { id: event.id }, user_id: service_provider.user.id }
      specify { expect(response).to redirect_to(service_provider_root_path) }
      specify { expect(Event.count).to eq(0) }
    end
  end
end
