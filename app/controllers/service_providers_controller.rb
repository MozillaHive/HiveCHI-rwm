class ServiceProvidersController < ApplicationController
  before_filter :require_login, :require_service_provider, except: [:new, :create]
  before_filter :require_no_login, only: [:new, :create]
  before_filter :require_registration_enabled, only: [:new, :create]

  def new
    @service_provider = ServiceProvider.new
    @service_provider.build_user
  end

  def create
    @service_provider = ServiceProvider.new(service_provider_params)
    if @service_provider.save
      session[:user_id] = @service_provider.user.id
      redirect_to users_verify_path
    else
      render 'new'
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

  def destroy
    if current_service_provider.destroy
      reset_session
      flash[:notice] = "Your account has been deleted."
      redirect_to login_path
    end
  end

  private

  def service_provider_params
    params.require(:service_provider).permit(
      user_attributes: [
        :id, :email, :phone, :password, :password_confirmation, :time_zone,
        :tos_accepted
      ]
    )
  end
end
