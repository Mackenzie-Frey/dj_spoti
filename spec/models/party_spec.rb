require 'rails_helper'

RSpec.describe PartyUser, type: :model do
  describe 'validations' do
    it { should belong_to(:user)}
    it { should belong_to(:party)}
  end

  describe 'party can have many users through' do
    it 'party_users table' do
      user = create(:user, name: 'manoj')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      party = create(:party, admin: user)
      party.users <<  create(:user, spotify_id: 2)
      party.users << create(:user, spotify_id: 3)
      party.users << create(:user, spotify_id: 4)

      expect(party.users.count).to eq(3)
    end
  end

  describe 'unique identifier is created when creating' do
    it 'a party' do
      user = create(:user, name: 'manoj')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      party = create(:party, admin: user)

      expect(party.identifier).to be(true)
    end
  end
end
