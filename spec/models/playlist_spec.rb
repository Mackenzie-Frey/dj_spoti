require 'rails_helper'

context 'The aggregated party playlist & seeds' do
  before :each do
    @user = create(:user, name: 'manoj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @party = create(:party, admin: @user)
    stub_spotify_top_plays

    @party.users <<  create(:user, spotify_id: 2, access_token: 'fake_token_request_is_stubbed')
    @party.users << create(:user, spotify_id: 3, access_token: 'fake_token_request_is_stubbed')
    @party.users << create(:user, spotify_id: 4, access_token: 'fake_token_request_is_stubbed')

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
    different_artist_seeds = "3JhNCzhSMTxs9WLGJJxWOY,6beUvFUlKliUYJdLOXNj9C,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6,3LjhVl7GzYsza1biQjTpaN"
    new_user = create(:user, name: 'new party animal', spotify_id: 5,
      access_token: 'fake_token_request_is_stubbed', seed_artists: different_artist_seeds)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(new_user)

    @playlist.aggregated_top_play_ids
    initial_playlist_seeds = @party.playlist_seeds

    @party.users << new_user
    @playlist.aggregated_top_play_ids

    expect(@party.playlist_seeds).to_not eq(initial_playlist_seeds)
    expect(@party.playlist_seeds).to be_a(String)
    expect(@party.playlist_seeds.length).to be(114)
    expect(@party.playlist_seeds.count(',')).to eq(4)
  end

  xit 'outputs the array Peregrine needs' do
    # Between the test setup and the below line, it creates parties with playlist_seeds,
    # and party_users with seed_artists
    @playlist.aggregated_top_play_ids

    #make sure this gets set in config and reset hourly
    # token = ENV['HOURLY_TOKEN']
    #
    # binding.pry
    #
    # SpotifyService.new(token).

    # want to call something like this:
    # SpotifyService.new(token).party_tracks
  end
end

#
# SpotifyService.new(token).party_tracks
