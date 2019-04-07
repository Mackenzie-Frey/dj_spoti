require 'rails_helper'
describe 'logged in user can' do
  it 'invite more than one to party' do
    stub_oauth_connection
    visit '/'
    click_on 'Connect With Spotify', match: :first

    click_on 'Start A New Party'

    fill_in 'party[name]', with: 'This is a party'
    click_on 'Create'

    click_button '+' ## have already tested someone invited can join Party
    ##just checking clicking + button adds a clone
    expect(page).to have_field('ph_number')
    expect(page).to have_field('ph_number1')
  end
end
