require 'rails_helper'
describe 'admin who have started party' do
  it 'can end party' do
    user = create(:user)
    stub_oauth_connection
    visit '/'
    click_on 'Connect With Spotify'

    click_on 'Start A New Party'
    fill_in 'party[name]', with: 'party'
    click_on 'Create'
    expect(Party.count).to eq(1)

    expect(current_path).to eq(dashboard_path)
    click_on 'End Party'

    expect(Party.count).to eq(0)
  end
end

describe 'non admim user cant'  do
  it 'end party but can  leave party' do
    user = create(:user)
    party = create(:party, identifier: 'abcd', admin: user)

    stub_oauth_connection## logged in user who is gonna join party next line
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