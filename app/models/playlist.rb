class Playlist
  def initialize(party_users)
    @party_users = party_users
  end

  def make
    SpotifyService.new(token).top_plays
  end

  def update(current_user)

  end
end
