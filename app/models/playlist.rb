class Playlist
  def initialize(party)
    @party = party
  end

  def aggregated_top_play_ids
    all_ids = @party.users.map do |party_user|
      user_top_plays(party_user)
    end
    id_collection = select_seeds(all_ids)
    tracks = SpotifyService.new(@party.admin).recommended_playlist(id_collection)
    @party.update_attributes(playlist_tracks: tracks)
    @party.save!

   # @party.playlist_seeds = select_seeds(all_ids)
   # @party.save!
  end

  def select_seeds(all_ids)
    binding.pry
    thing = all_ids.map do |party_user_ids|
      party_user_ids.split(",")
    end.flatten.uniq.sample(5).join(',')
  end

  def user_top_plays(party_user)
    if party_user.seed_artists.nil?
      party_user.update!(seed_artists:
      SpotifyService.new(party_user).top_plays)
    end
    party_user.seed_artists
  end
end
