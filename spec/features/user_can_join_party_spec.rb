require 'rails_helper'
describe 'user clicking invitation link' do
  it 'can join party' do
    stub_oauth_connection
    stub_spotify_top_plays
    
    user = create(:user)
    party = create(:party, identifier: 'abcd', admin: user)

    visit '/join?i=abcd'

    expect(party.users.count).to eq(1)
    expect(party.users.include?(User.last)).to be(true)
  end
end
