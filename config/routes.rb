Rails.application.routes.draw do
  root 'welcome#index'

  get 'login' => 'session#login'
  get 'dashboard' => 'welcome#dashboard'

  get 'redirect' => 'session#redirect'

  get 'mynudges' => 'nudges#show'
  get 'events/:id/nudge' => 'nudges#new'
  post 'events/:id/nudge' => 'nudges#create'

  get 'login' => 'session#new'
  post 'login' => 'session#create'

  delete 'logout' => 'session#destroy'

  get 'register' => 'users#new'
  get 'users/verify' => 'users#verification'
  post 'users/verify' => 'users#verify'
  get 'users/verify-email' => 'users#verify_email'
  post 'users/verify-email' => 'users#resend_confirmation_email'
  resource :user, only: [:edit, :update]
  resource :password_reset, except: [:index, :show, :update]
  resources :students, only: [:new, :create]
  resources :parents, only: [:new, :create]

  resources :events do
    resources :attendances
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
