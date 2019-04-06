require 'rails_helper'
describe 'logged in user can logout' do
  it 'by clicking logou in the nav bar ' do

    visit '/'
    stub_oauth_connection
    mock_auth = OmniAuth.config.mock_auth[:spotify]
    Rails.application.env_config['omniauth.auth'] = mock_auth

    expect(page).to_not have_link('Logout')

    click_button 'Connect With Spotify'

    expect(page).to_not have_button('Connect With Spotify')

    expect(current_path).to eq(dashboard_path)
    click_on 'Logout'
    expect(page).to have_button('Connect With Spotify')
    expect(page).to_not have_button('Logout')
  end
end
