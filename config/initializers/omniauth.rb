Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'],
  scope: %w(
    playlist-read-private
    user-read-private
    user-read-email
    user-top-read
    user-read-birthdate
    user-read-playback-state
    streaming
  ).join(' ')
end
