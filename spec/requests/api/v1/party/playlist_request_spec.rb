require 'rails_helper'

describe 'Party Playlist API' do
  it 'returns an array of artists' do
    admin = create(:user)
    party = create(:party, admin_id: admin.id, playlist_tracks: "[
    \"spotify:track:11hQq4yWgnys6cYprSDiYL\",
    \"spotify:track:0o0w7R5s7FT60liDBgxVFC\"]")
    allow_any_instance_of(Api::V1::Party::PlaylistController)
    .to receive(:current_party)
    .and_return(party)

    get '/api/v1/parties/sT2HI933ZQoY6qxowOR0vw/playlist'
    json = JSON.parse(response.body)

    expect(json).to be_a(Array)
    expect(json[0]).to eq("spotify:track:11hQq4yWgnys6cYprSDiYL")
  end
end
