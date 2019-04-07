class Playlist
  def initialize(party_users)
    @party_users = party_users
  end

  def make_playlist_seeds
    SpotifyService.new(token).top_plays
  end

  def update_playlist_seeds

  end
end
