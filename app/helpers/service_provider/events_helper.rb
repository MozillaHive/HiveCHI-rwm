module ServiceProvider::EventsHelper
  def service_provider_event_form_path
    if @event.persisted?
      service_provider_event_path(@event)
    else
      service_provider_events_path
    end
  end
end
