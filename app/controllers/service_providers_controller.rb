class ServiceProvidersController < ApplicationController
  before_filter :require_service_provider, except: :create

  def create
    @service_provider = ServiceProvider.new(service_provider_params)
    if ENV["DISABLE_REGISTRATIONS"] == "TRUE"
      render 'new'
    elsif @service_provider.save
      session[:user_id] = @service_provider.user.id
      redirect_to users_verify_path
    else
      assign_all_role_types
      render 'users/new'
    end
  end

  def edit
    @service_provider = current_service_provider
  end

  def update
    @service_provider = current_service_provider
    if @service_provider.update(service_provider_params)
      redirect_to home_path
    else
      render 'edit'
    end
  end

  private

  def service_provider_params
    params.require(:service_provider).permit(
      :organization_id, user_attributes: [:id, :email, :phone, :password,
      :password_confirmation, :time_zone]
    )
  end
end
