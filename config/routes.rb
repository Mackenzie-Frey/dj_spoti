# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'party/create'
  get 'party/new'
  root 'home#index'
  get '/dashboard', to: 'dashboard#index'
  get '/logout', to: 'sessions#destroy'

  get 'auth/spotify', as: 'spotify_omniauth'

  get '/connect', to: redirect("/auth/spotify")

  get 'auth/spotify/callback', to: 'sessions#create'
  post '/invite', to: 'invitation#create'

  get '/join', to: 'join#show'
  delete '/party_users', to: 'party_users#destroy'

   mount ActionCable.server => '/cable'

  resources :party

  namespace :api do
    namespace :v1 do
      get '/parties/:identifier/player_state_changed', to: 'party#show', param: :identifier, as: 'check_song'

    end
  end


end
