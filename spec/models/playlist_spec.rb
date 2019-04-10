require 'rails_helper'

context 'The aggregated party playlist & seeds' do
  before :each do
    @user = create(:user, name: 'manoj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @party = create(:party, admin: @user)

    @party.users <<  create(:user, spotify_id: 2, access_token: 'fake_token_request_is_stubbed')
    @party.users << create(:user, spotify_id: 3, access_token: 'fake_token_request_is_stubbed')
    @party.users << create(:user, spotify_id: 4, access_token: 'fake_token_request_is_stubbed')

    @playlist = Playlist.new(@party)
  end

  it 'exist' do
    expect(@playlist).to be_a(Playlist)
  end

  it '#aggregated_top_play_ids - is made when a party is created' do
    stub_spotify_top_plays
    stub_select_seeds
    stub_recommended_playlist
    @playlist.aggregated_top_play_ids

    expect(@party.playlist_tracks).to be_a(String)
    expect(@party.playlist_tracks).to eq("[\"spotify:track:4IlBZXHTwY7DoxA4piiHtM\", \"spotify:track:2LNdH3B2gCOw3Uh1jIXG3Z\"]")
  end

  it '#update - updates when a non-admin user joins a party' do
    different_artist_seeds = "3JhNCzhSMTxs9WLGJJxWOY,6beUvFUlKliUYJdLOXNj9C,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6,3LjhVl7GzYsza1biQjTpaN"
    new_user = create(:user, name: 'new party animal', spotify_id: 5,
      access_token: 'fake_token_request_is_stubbed', seed_artists: different_artist_seeds)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(new_user)
    # stub_spotify_top_plays
    # @party.users << new_user
    # @playlist.aggregated_top_play_ids
    stub_spotify_top_plays
    stub_select_seeds_intitial_party
    stub_recommended_playlist_initial_party

    @playlist.aggregated_top_play_ids
    initial_playlist_seeds = @party.playlist_tracks

    stub_select_seeds_user_joins_party
    stub_recommended_playlist_user_joins_party

    @party.users << new_user
    @playlist.aggregated_top_play_ids

    expect(@party.playlist_tracks).to_not eq(initial_playlist_seeds)
    expect(@party.playlist_tracks).to be_a(String)
  end

  # it 'outputs the array Peregrine needs' do
  #   # Between the test setup and the below line, it creates parties with playlist_seeds,
  #   # and party_users with seed_artists
  #   @playlist.aggregated_top_play_ids
  #
  #   # binding.pry
  #
  #   SpotifyService.new(@user).party_tracks
  #   # Peregrine wants this
  #   #["spotify:track:<track_id>","spotify:track:<track_id>","spotify:track:<track_id>"]
  #   # save to database the track ids probably on extract track ids method.... maybe not because we need the party
  # end
end

# delete playlist_seeds form db
# does it update a party playlist each time a user joins
# maybe select_seeds(all_ids) should be an array of seeds
# parse data for Peregrine ie extract new line characters

# change double quotes on inner to single quotes for extract_track_ids and that it saves to db.
