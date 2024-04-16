# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => 'admin/sidekiq'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Users::Api => '/user_api'
  mount GrapeSwaggerRails::Engine => '/user-api-docs'
  
  mount Artists::Api => '/artist_api'
  mount GrapeSwaggerRails::Engine => '/artist-api-docs', as: 'artist_api_docs'

  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }, path: 'auth'

  devise_for :users,
             only: :omniauth_callbacks,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  get '/users/token', to: 'users#token'
end
