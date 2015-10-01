class ServiceProvider::EventsController < ApplicationController
  before_filter :require_service_provider
  before_filter :require_ownership, except: [:index, :new, :create]

  def index
    @events = current_service_provider.organization.events
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_service_provider.organization.events.build
  end

  def create
    @event = current_service_provider.organization.events.build(event_params)
    if @event.save
      redirect_to service_provider_event_path(@event)
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to service_provider_event_path(@event)
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to service_provider_root_path
    else
      render 'show'
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :address, :start_date_and_time, :duration, :description,
      :event_type
    )
  end

  def require_ownership
    unless Event.find(params[:id]).organization == current_service_provider.organization
      redirect_to service_provider_root_path
    end
  end
end
