class AddPlaylistTracksToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :playlist_tracks, :string
  end
end
