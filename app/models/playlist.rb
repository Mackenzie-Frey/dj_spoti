class Playlist
  def initialize(party)
    @party = party
    @party_users = party.users
  end

  def aggregated_top_play_ids
    all_ids = @party_users.map do |party_user|
      # memoize the below line?
      # when to invalidate this cache, every couple days?
      SpotifyService.new(party_user.access_token).top_plays
    end
     @party.playlist_seeds = select_seeds(all_ids)
     @party.save!
  end

  def select_seeds(all_ids)
    all_ids.flatten.uniq.sample(5).join(',')
  end

#   def update(current_user)
# binding.pry
#   end
end
