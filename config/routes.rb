# frozen_string_literal: true

Rails.application.routes.draw do

  get 'party/create'
  get 'party/new'

  root 'home#index'
  get '/dashboard', to: 'dashboard#index'
  get '/logout', to: 'sessions#destroy'


  get '/connect', to: redirect("/auth/spotify")

  get 'auth/spotify/callback', to: 'sessions#create'
  get 'auth/spotify', as: 'spotify_omniauth'
  post '/invite', to: 'invitation#create'

  get '/join', to: 'join#show'

  delete '/party_users', to: 'party_users#destroy'

  mount ActionCable.server => '/cable'

  resources :party

  namespace :api do
    namespace :v1 do
      get '/parties/:identifier/player_state_changed', to: 'party#show', param: :identifier, as: 'check_song'
      get 'parties/:identifer/playlist', to: 'party/playlist#show', param: :identifier, as: 'party_playlist'
    end
  end


end
