class AddPlaylistSeedsToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :playlist_seeds, :string
  end
end
