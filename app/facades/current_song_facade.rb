class CurrentSongFacade
  attr_reader :id,
              :name,
              :artists,
              :album,
              :image
              
  def initialize(current_song_data_hash)
    @id = current_song_data_hash[:id]
    @name = current_song_data_hash[:name]
    @artists= current_song_data_hash[:artists]
    @album = current_song_data_hash[:album]
    @image = current_song_data_hash[:image]
  end
end
