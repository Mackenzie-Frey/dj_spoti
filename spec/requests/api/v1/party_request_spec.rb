require 'rails_helper'

describe 'Party API' do
  it 'returns an array of artists' do
    admin = create(:user)
    party = create(:party, admin_id: admin.id, identifier: 'i')
    data = {
      item: {
        id: '2pDmVE3XfgbuZDFPsLISUu',
        name: 'January',
        artists: [
          {name: 'Disclosure'}
        ],
        album: {
          name: 'Settle',
          images: [
            {url: 'https://i.scdn.co/image/0890496ee677e2db460643892540b738b660a4b6'}
          ]
        }
      }
    }
    # allow_any_instance_of(Api::V1::PartyController)
    # .to receive(:party)
    # .and_return(party)
    allow_any_instance_of(SongFacade)
    .to receive(:current_song)
    .and_return(Song.new(data))

    get '/api/v1/parties/i/player_state_changed'
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to eq({message: "Song Updated!"})
  end
end
