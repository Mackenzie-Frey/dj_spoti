class Song
  attr_reader :id,
              :name,
              :artists,
              :album,
              :image

  def initialize(data)
    @id = data[:item][:id]
    @name = data[:item][:name]
    @artists = data[:item][:artists].map { |a| a[:name] }
    @album = data[:item][:album][:name]
    @image = data[:item][:album][:images][0][:url]
  end

  def serialize_data
    {
      id: @id,
      name: @name,
      artists: @artists,
      album: @album,
      image: @image
    }
  end

  # def self.song_object(data)
  #   @id = data[:id]
  #   @name = data[:name]
  #   @artists = data[:artists]
  #   @album = data[:album]
  #   @image = data[:image]
  #   return self
  # end
end
