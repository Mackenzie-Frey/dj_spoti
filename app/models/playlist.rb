class Playlist
  def initialize(party_users)
    @party_users = party_users
  end

  def make
    binding.pry
    thing = @party_users.map do |party_user|
      SpotifyService.new(party_user.access_token).top_plays
    end
  end

  def update(current_user)

  end
end
