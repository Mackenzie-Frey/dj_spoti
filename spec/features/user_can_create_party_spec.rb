require 'rails_helper'
describe 'user visiting dashboard_path' do
  it 'can create party with a name' do
    stub_oauth_connection
    visit '/'
    click_on 'Connect With Spotify', match: :first

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_button('Start A New Party')

    click_on 'Start A New Party'

    fill_in 'party[:name]', with: 'This is a party'
    click_on 'Create'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('This is a party')
  end
end
