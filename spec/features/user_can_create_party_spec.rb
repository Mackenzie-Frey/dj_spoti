require 'rails_helper'
describe 'user visiting dashboard_path' do
  it 'can create party with a name' do
    create(:user, name: 'test')
    stub_spotify_top_plays
    stub_oauth_connection

    stub_select_seeds
    stub_recommended_playlist

    visit '/'
    click_on 'Connect With Spotify', match: :first

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_button('Start Party')

    click_on 'Start Party'

    fill_in 'party[name]', with: 'This is a party'
    fill_in 'ph_number', with: '7206832645'
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
      stub_select_seeds
      stub_recommended_playlist

      visit '/'
      click_on 'Connect With Spotify', match: :first

      click_on 'Start Party'

      fill_in 'party[name]', with: 'This is a party'
      click_on 'Create'

      expect(Party.first.identifier).to be_a(String)
    end
  end
end
