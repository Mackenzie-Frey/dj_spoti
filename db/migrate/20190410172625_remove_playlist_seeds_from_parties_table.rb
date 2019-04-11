class RemovePlaylistSeedsFromPartiesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :parties, :playlist_seeds
  end
end
