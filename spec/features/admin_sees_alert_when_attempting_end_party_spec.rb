# require 'rails_helper'
# describe 'admin trying to end party ' do
#   it 'sees and alert' do
#     stub_oauth_connection
#     visit '/'
#     click_on 'Connect With Spotify'
#
#     click_on 'Start A New Party'##start button clicked
#     fill_in 'party[name]', with: 'party'##filled out form for party name
#     click_on 'Create'##click on create
#     click_on 'End Party'##party is started now click on end party
#     save_and_open_page
#
#     expect(page).to have_content('Are you sure you want to kick all party animals out of this party?')
#   end
# end

describe 'non admim user cant'  do
  it 'end party but can  leave party' do
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
