# frozen_string_literal: true

Rails.application.routes.draw do
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

  get '/profile', to: 'profile#show'
  get '/song_search', to: 'song_search#index'
end
