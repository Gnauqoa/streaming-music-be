Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount V1::Users::Api => '/api/v1'

  mount GrapeSwaggerRails::Engine => '/v1-user-api-docs'

  # devise_for :admin_users, controllers: {
  #   sessions: 'admin_users/sessions'
  # }, path: 'auth'

  # devise_for :users,
  #            only: :omniauth_callbacks,
  #            controllers: {
  #              omniauth_callbacks: 'users/omniauth_callbacks'
  #            }
  # get '/users/token', to: 'users#token'

  # Defines the root path route ("/")
  # root "posts#index"
end
