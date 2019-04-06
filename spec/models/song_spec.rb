require 'rails_helper'

describe 'Song' do
  before :each do
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
    expect(@song).to be_a(Song)
  end

  describe 'attributes' do
    it '#id' do
      expect(@song.id).to eq('2pDmVE3XfgbuZDFPsLISUu')
    end
    it '#name' do
      expect(@song.name).to eq('January')
    end
    it '#artists' do
      expect(@song.artists).to eq(['Disclosure'])
    end
    it '#album' do
      expect(@song.album).to eq('Settle')
    end
    it '#image' do
      expect(@song.image).to eq('https://i.scdn.co/image/0890496ee677e2db460643892540b738b660a4b6')
    end
  end
end
