require 'rails_helper'
describe 'logged in user can' do
  it 'invite people to party' do
    stub_oauth_connection
    visit '/'
    click_on 'Connect With Spotify', match: :first

    click_on 'Start A New Party'

    fill_in 'party[name]', with: 'This is a party'
    click_on 'Create'
    save_and_open_page

    expect(current_path).to eq(dashboard_path)
  end
end
