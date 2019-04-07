require 'rails_helper'
describe 'user who have already joined' do
  it 'can leave party' do
    user = create(:user)
    stub_oauth_connection
    visit '/'
    click_on 'Connect With Spotify'

    click_on 'Start A New Party'
    fill_in 'party[name]', with: 'party'
    click_on 'Create'
    expect(Party.count).to eq(1)

    click_on 'End Party'

    expect(Party.count).to eq(0)
  end
end
