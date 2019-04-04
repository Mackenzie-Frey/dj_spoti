Rails.application.routes.draw do
  root 'home#index'
  post '/register', to: redirect('/auth/spotify')
  get 'auth/spotify/callback', to: 'users#create'
end
