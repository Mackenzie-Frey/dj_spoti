require 'rails_helper'

context 'The aggregated party playlist & seeds' do
  before :each do
    @user = create(:user, name: 'manoj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @party = create(:party, admin: @user)

    # these users all have the same key which expires every hour
    # this test setup will need to be re-done utilizing the refresh_token,
    # once that functionality is integrated.

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








# In order to get the json objects for top_plays for all party users
# at specific party, I will make a class method for PartyUser which takes an argument
# of the party_id and find all party_users where_party_id matches ie method name:

# Then I will make an api call for SpotifyService.(token).top_plays for each party_user
# at the party. This endpoint for the top_plays is updated once a day. We are
# using the param of medium_term on this endpoint, which is the last 6 months and likely
# won't change frequently. Thinking I'll memoize this api call for each party user( SpotifyService.(token).top_plays )
# I'm not sure how to go about invalidating this yet, as presumably we wouldn't want the
# top plays for a user to be frozen forever based on the first api call. Haven't figured out this part yet.
# We'll need some sort of logic
# From there I'm thinking of making a model instance method for PartyUsers to
# get their

# As we can only submit 5 artists, my thoughts are to
# shuffle.limit(5)

# END Get 5 artist ids ->>The Spotify Service recommended_playlist method takes a
# argument of "artist_id1,artist_id2,etc" with up to 5 artist ids.
