require 'rails_helper'
describe 'user visiting dashboard_path' do
  it 'can create party with a name' do
    create(:user, name: 'test')
    stub_spotify_top_plays
    stub_oauth_connection

    all_ids = ["3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,6beUvFUlKliUYJdLOXNj9C,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"]
    id_collection = "6beUvFUlKliUYJdLOXNj9C,3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"
    allow_any_instance_of(Playlist).to receive(:select_seeds).with(all_ids).and_return(id_collection)

    stub_recommended_playlist

    visit '/'
    click_on 'Connect With Spotify', match: :first

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_button('Start A New Party')

    click_on 'Start A New Party'

    fill_in 'party[name]', with: 'This is a party'
    click_on 'Create'

    expect(current_path).to eq(dashboard_path)

    expect(Party.count).to eq(1)
    expect(Party.first.admin).to eq(User.last)
    expect(Party.first.playlist_tracks).to be_a(String)
    expect(Party.first.playlist_tracks).to eq("[\"spotify:track:4IlBZXHTwY7DoxA4piiHtM\", \"spotify:track:2LNdH3B2gCOw3Uh1jIXG3Z\"]")
  end

  describe 'unique identifier is created when creating' do
    it 'a party' do
      create(:user, name: 'test')
      stub_spotify_top_plays
      stub_oauth_connection
      visit '/'
      click_on 'Connect With Spotify', match: :first

      click_on 'Start A New Party'

      fill_in 'party[name]', with: 'This is a party'
      click_on 'Create'

      expect(Party.first.identifier).to be_a(String)
    end
  end
end
