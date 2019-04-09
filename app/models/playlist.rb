class Playlist
  def initialize(party)
    @party = party
  end

  def aggregated_top_play_ids
    all_ids = @party.users.map do |party_user|
      user_top_plays(party_user)
    end
   @party.playlist_seeds = select_seeds(all_ids)
   @party.save!
  end

  def select_seeds(all_ids)
    all_ids.flatten.uniq.sample(5).join(',')
  end

  def user_top_plays(party_user)
    if party_user.seed_artists.nil?
      party_user.update!(seed_artists:
      SpotifyService.new(party_user.access_token).top_plays)
    end
    party_user.seed_artists
  end
end

# time = Benchmark.measure do
#   SpotifyService.new(party_user.access_token).top_plays
# end

# rake task to update it the values.

# run just model testing to fill simplcov holes

# Make an endpoint/Serializer for Web Player to hit with the tracks or save
# save the tracks to the db on the party and update when a new user joins.

# Calls a new playlist at the end of each song
