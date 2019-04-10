require 'rails_helper'
describe 'admin who have started party' do
  context 'can end party' do
    it 'removes all users from party when ending' do
      stub_oauth_connection
      stub_spotify_top_plays

      visit '/'
      click_on 'Connect With Spotify'

      click_on 'Start A New Party'
      fill_in 'party[name]', with: 'party'
      click_on 'Create'
      expect(Party.count).to eq(1)

      party = Party.first
      create(:user, party_id: party.id)
      create(:user, party_id: party.id)
      create(:user, party_id: party.id)

      expect(party.users.count).to eq(4)

      expect(current_path).to eq(dashboard_path)
      click_on 'End Party'

      expect(Party.count).to eq(0)
      expect(User.find_by(party_id: party.id)).to eq(nil)
    end
  end

  context 'non admin user cant end party'  do
    it 'but can leave party' do
      user = create(:user)
      party = create(:party, identifier: 'abcd', admin: user)

      stub_oauth_connection## logged in user who is gonna join party next line
      stub_spotify_top_plays
      visit '/join?i=abcd'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_button('End Party')
      expect(page).to_not have_content('End Party')

      click_on 'Leave Party'

      expect(page).to_not have_content(party.name)
      expect(Party.count).to eq(1)##just making sure normal user is not destroying party

      expect(page).to have_button("Start A New Party")
    end
  end
end
