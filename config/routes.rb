# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/dashboard', to: 'dashboard#index'
  get '/logout', to: 'sessions#destroy'
  post '/connect', to: redirect('/auth/spotify')
  get 'auth/spotify/callback', to: 'sessions#create'
end
