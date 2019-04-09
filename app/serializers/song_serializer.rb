class SongSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :artists,
             :album,
             :image
end
