class AddSeedArtistsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :seed_artists, :string
  end
end
