# frozen_string_literal: true

Rails.application.routes.draw do
  get 'party/create'
  get 'party/new'
  root 'home#index'
  get '/dashboard', to: 'dashboard#index'
  get '/logout', to: 'sessions#destroy'
  post '/connect', to: redirect('/auth/spotify')
  get 'auth/spotify/callback', to: 'sessions#create'

   mount ActionCable.server => '/cable'

  resources :party
end
