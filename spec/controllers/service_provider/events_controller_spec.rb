require 'rails_helper'

RSpec.describe ServiceProvider::EventsController, type: :controller do
  let(:unowned_event) { create(:event) }

  before do
    @organization = create(:organization)
    @service_provider = create(
      :service_provider, organization_id: @organization.id
    )
    @event = create(:event, organization_id: @organization.id)
  end

  describe "GET #index" do
    context "when not logged in" do
      before { get :index }
      specify { expect(response).to redirect_to(root_path) }
    end

    context "when logged in" do
      before { get :index, nil, user_id: @service_provider.user.id }
      specify { expect(response).to render_template("index") }
      specify { expect(assigns(:events)).to eq([@event]) }
    end
  end

  describe "GET #show" do
    context "when not logged in" do
      before { get :show, id: @event.id }
      specify { expect(response).to redirect_to(root_path) }
    end

    context "when logged in and resource is not owned" do
      before { get :show, { id: unowned_event.id }, user_id: @service_provider.user.id }
      specify { expect(response).to redirect_to(service_provider_root_path) }
    end

    context "when logged in and resource is owned" do
      before { get :show, { id: @event.id }, user_id: @service_provider.user.id }
      specify { expect(response).to render_template("show") }
      specify { expect(assigns(:event)).to eq(@event) }
    end
  end
end
