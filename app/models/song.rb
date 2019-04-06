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
end
