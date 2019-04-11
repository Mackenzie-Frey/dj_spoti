class SessionsController < ApplicationController

  def create
    party = Party.find_by(identifier: request.env["omniauth.params"]["url"]) if request.env["omniauth.params"]["url"]
    user = User.find_or_create_by!(spotify_id: spotify_params[:spotify_id]) do |u|
      u.name = spotify_params[:name]
    end
    user.update(expires_at: Time.at(spotify_params[:expires_at]).utc)
    user.update(access_token: spotify_params[:access_token])
    user.update(refresh_token:   spotify_params[:refresh_token])
    login_user(user)
    join_party(party) if party
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    session[:party_identifier] = nil
    redirect_to root_path
  end

  private

  def spotify_params
    spotify_info ={}
    spotify_info[:name] = request.env['omniauth.auth'].info[:name]
    spotify_info[:spotify_id] = request.env['omniauth.auth'].uid
    spotify_info[:access_token] = request.env['omniauth.auth'].credentials.token
    spotify_info[:refresh_token] = request.env['omniauth.auth'].credentials.refresh_token
    spotify_info[:expires_at] = request.env['omniauth.auth'].credentials.expires_at
    spotify_info
  end

  def login_user(user)
    if user
      session[:user_id] = user.id
      flash[:success] = 'You Have Successfully Connected With Spotify'
    else
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end

  def join_party(party)
    party.users << current_user unless party.users.include?(current_user)
    session[:party_identifier] = party.identifier
    new_playlist(party)
  end
end
