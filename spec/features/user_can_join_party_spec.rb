require 'rails_helper'
describe 'user clicking invitation link' do
  it 'can join party' do
    stub_oauth_connection
    stub_spotify_top_plays
    stub_select_seeds
    stub_recommended_playlist

    user = create(:user)
    party = create(:party, identifier: 'abcd', admin: user)

    stub_oauth_connection

    visit '/join?i=abcd'

    expect(party.users.count).to eq(1)
    expect(party.users.include?(User.last)).to be(true)
  end
end
