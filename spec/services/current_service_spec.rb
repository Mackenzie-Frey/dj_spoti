require 'rails_helper'

describe 'CurrentService' do
  before :each do
    @admin = create(:user)
    @party = create(:party, admin_id: @admin.id, current_song: nil)
    @service = CurrentService.new(@party)
    @data = {
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
    @song = Song.new(@data)
  end
  it 'exists' do
    expect(@service).to be_a(CurrentService)
  end

  it '#check_for_track_change' do
    expect(@party.current_song).to_not eq(@song)

    allow_any_instance_of(SongFacade)
      .to receive(:current_song)
      .and_return(@song)

    @service.check_for_track_change

    expect(@party.current_song).to eq(@song)
  end
end
