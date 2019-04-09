require 'rails_helper'

feature 'As a User visiting /profile' do
  scenario 'I can enter a song into the search bar and set it to my theme song' do
    stub_oauth_connection
    visit '/'

    click_on 'Connect With Spotify'

    visit '/profile'
    fill_in :song_name, with: "Don't Stop Believin'"
    click_on 'Search'

    expect(current_path).to eq(song_search_path)

    click_on 'Set as Theme Song'

    expect(current_path).to eq(set_song_path)
    within '.theme_song' do
      expect(page).to have_css('.title')
    end
  end
end

uri = URI('https://api.spotify.com/v1/search')
req = Net::HTTP::Get.new(uri)
req['Authorization'] = token

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.start do |h|
  req = Net::HTTP::Get.new(uri.request_uri)
  req['Authorization'] = token
  h.request req

  h.request Net::HTTP::Get.new(uri.request_uri)
end
