require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should belong_to(:admin) }
    it { should have_many(:users) }
  end

  describe 'party can have many users through' do
    it 'party table' do
      user = create(:user, name: 'manoj')

      party = create(:party, admin: user)
      party.users <<  create(:user, spotify_id: 2)
      party.users << create(:user, spotify_id: 3)
      party.users << create(:user, spotify_id: 4)

      expect(party.users.count).to eq(3)
    end
  end
end
