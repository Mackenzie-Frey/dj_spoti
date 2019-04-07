class SessionsController < ApplicationController
  def create
    party = Party.find_by(identifier: request.env["omniauth.params"]["url"]) if request.env["omniauth.params"]["url"]
    if user = User.find_by(spotify_id: spotify_params(request.env['omniauth.auth'])[:spotify_id])
      session[:user_id] = user.id
      session[:party_identifier] = party.identifier if party
      flash[:success] = 'You Have Successfully Connected With Spotify'
    else
      user = User.new(spotify_params(request.env['omniauth.auth']))
      register_and_login_user(user, party)
    end
    join_party(party) if party
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
    spotify_info
  end

  def register_and_login_user(user, party)
    if user.save
      session[:user_id] = user.id
      session[:party_identifier] = party.identifier if party
      flash[:success] = 'You Have Successfully Connected With Spotify'
    else
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end

  def join_party(party)
    party.users << current_user
  end
end
