class Playlist
  def initialize(party)
    @party = party
    @party_users = party.users
  end

  def aggregated_top_play_ids
    all_ids = @party_users.map do |party_user|
      party_user.seed_artists
    end
     @party.playlist_seeds = select_seeds(all_ids)
     @party.save!
  end

  def select_seeds(all_ids)
    all_ids.flatten.uniq.sample(5).join(',')
  end

  def user_top_plays
    if party_user.seed_artists
      party_user.seed_artists
    else
      party_user.update!(seed_artists:
      SpotifyService.new(party_user.access_token).top_plays)
    end
  end
end

# time = Benchmark.measure do
#   SpotifyService.new(party_user.access_token).top_plays
# end

# rake task to update it the values.

# run just model testing to fill simplcov holes
