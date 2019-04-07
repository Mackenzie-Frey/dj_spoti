require 'rails_helper'

context 'The aggregated party playlist' do
  it 'exists' do
    user = create(:user, name: 'manoj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    party = create(:party, admin: user)
    party.users <<  create(:user, spotify_id: 2)
    party.users << create(:user, spotify_id: 3)
    party.users << create(:user, spotify_id: 4)
    
    playlist = Playlist.new(party.users)
    expect(playlist).to be_a(Playlist)
  end
end
