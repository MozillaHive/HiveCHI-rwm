Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :service_provider do
    root 'events#index'
    resources :events, except: [:index]
  end

  root 'welcome#index'

  get 'dashboard' => 'welcome#dashboard'

  get 'redirect' => 'session#redirect'

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout' => 'session#destroy'

  get 'register' => 'users#new'
  get 'tos' => 'users#tos'
  get 'users/verify' => 'users#verification'
  post 'users/verify' => 'users#verify'
  get 'users/verify-email' => 'users#verify_email'
  post 'users/verify-email' => 'users#resend_confirmation_email'
  resource :password_reset, except: [:index, :show, :update]
  resource :student
  resource :parent
  resource :service_provider

  resources :events do
    resources :attendances
    resources :nudges, shallow: true
  end
end
