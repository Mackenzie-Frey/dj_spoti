require 'rails_helper'

context 'The aggregated party playlist & seeds' do
  before :each do
    @user = create(:user, name: 'manoj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @party = create(:party, admin: @user)
    stub_spotify_top_plays

    # test in the party for a playlist being created
    # these users all have the same key which expires every hour
    # this test setup will need to be re-done utilizing the refresh_token,
    # once that functionality is integrated.
    # Make a test that when a user logs in and hits create a party,
    # that they have a playlist for that new party.

    @party.users <<  create(:user, spotify_id: 2, access_token: ENV['HOURLY_SPOTIFY_TOKEN'])
    @party.users << create(:user, spotify_id: 3, access_token: ENV['HOURLY_SPOTIFY_TOKEN'])
    @party.users << create(:user, spotify_id: 4, access_token: ENV['HOURLY_SPOTIFY_TOKEN'])

    @playlist = Playlist.new(@party)
  end

  it 'exist' do
    expect(@playlist).to be_a(Playlist)
  end

  it '#aggregated_top_play_ids - is made when a party is created' do
    @playlist.aggregated_top_play_ids

    expect(@party.playlist_seeds).to be_a(String)
    expect(@party.playlist_seeds.length).to be(114)
    expect(@party.playlist_seeds.count(',')).to eq(4)
  end

  it '#update - updates when a non-admin user joins a party' do
    new_user = create(:user, name: 'new party animal', spotify_id: 5, access_token: ENV['HOURLY_SPOTIFY_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(new_user)
    @party.users << new_user

    # run coverage to see what is not tested
    # add a user to a party to call the update method
    # or add to test for a user joining a party that it changes the playlist_seeds
    # should any vcr's be used
    @playlist.aggregated_top_play_ids
    initial_playlist_seeds = @party.playlist_seeds

    @playlist.aggregated_top_play_ids

    expect(@party.playlist_seeds).to_not eq(initial_playlist_seeds)
    expect(@party.playlist_seeds).to be_a(String)
    expect(@party.playlist_seeds.length).to be(114)
    expect(@party.playlist_seeds.count(',')).to eq(4)
  end
end
