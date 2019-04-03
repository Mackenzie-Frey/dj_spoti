require 'rails_helper'

feature 'as a visitor' do
  context 'when visiting the homepage' do
    before :each do
      visit '/'
    end

    it 'sees a navbar' do
      expect(page).to have_css('nav')

      within 'nav' do
        expect(page).to have_link('Login')
        expect(page).to have_link('Register with Spotify')
        expect(page).to have_link('About')
      end
    end

    it 'sees an about section' do
      expect(page).to have_css('#about')
      within '#about' do
        expect(page).to have_content(
          'At parties, there is often one person who ends up being in charge of the music. What if everyone’s preferences could be taken into consideration by simply inviting one’s friends via a text message, from there, the music would then take care of itself. DJ Spoti aggregates the favorite songs of all session party users and cultivates a playlist with all user preferences in mind.'
        )
      end
    end
  end
end
