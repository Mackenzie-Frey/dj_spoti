require 'rails_helper'
describe 'logged in user can' do
  it 'invite people to party' do
    stub_oauth_connection
    visit '/'
    click_on 'Connect With Spotify', match: :first

    click_on 'Start A New Party'

    fill_in 'party[name]', with: 'This is a party'
    click_on 'Create'


    fill_in 'ph_number', with: '7206832645'
    click_on 'Invite'

    expect(Party.first.users.count).to eq(2)
  end
end
