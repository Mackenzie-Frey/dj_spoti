class Playlist
  def initialize(party)
    @party = party
    @party_users = party.users
  end

  def aggregated_top_play_ids
    all_ids = @party_users.map do |party_user|
      binding.pry
      user_top_plays(party_user)
    end
     @party.playlist_seeds = select_seeds(all_ids)
     @party.save!
  end

  def select_seeds(all_ids)
    all_ids.flatten.uniq.sample(5).join(',')
  end

# might need to be adjusted after saving seed artists to users db
  def user_top_plays(party_user)
    SpotifyService.new(party_user.access_token).top_plays
  end
end

# time = Benchmark.measure do
#   SpotifyService.new(party_user.access_token).top_plays
# end

# create a migration to add seed_artists to a users

# Manually store the value for the api call by running an if statement

# rake task to update it the values.
