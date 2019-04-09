class SongSearchFacade
  def initialize(query, user)
    @query = query
    @user = user
  end

  def songs
    SpotifyService.new(@user.access_token).search(@query).each do |song|
      Song.new(song)
    end
  end
end
