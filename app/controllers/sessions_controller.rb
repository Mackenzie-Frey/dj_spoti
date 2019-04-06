class SessionsController < ApplicationController
  def create
    if user = User.find_by(spotify_id: spotify_params(request.env['omniauth.auth'])[:spotify_id])
      session[:user_id] = user.id
      flash[:success] = 'You Have Successfully Connected With Spotify'
    else
      user = User.new(spotify_params(request.env['omniauth.auth']))
      register_and_login_user(user)
    end
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def spotify_params(auth_hash)
    spotify_info = {}
    spotify_info[:name] = auth_hash.info[:name]
    spotify_info[:spotify_id] = auth_hash.uid
    spotify_info[:access_token] = auth_hash.credentials.token
    spotify_info[:refresh_token] = auth_hash.credentials.refresh_token
    spotify_info[:expires_at] = auth_hash.credentials.expires_at
    spotify_info[:expires] = auth_hash.credentials.expires
    spotify_info
  end

  def register_and_login_user(user)
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'You Have Successfully Connected With Spotify'
    else
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end
end
