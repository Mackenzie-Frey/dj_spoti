# frozen_string_literal: true

require 'rails_helper'

feature 'as a visitor' do
  context 'when visiting the homepage' do
    before :each do
      visit '/'
    end

    it 'sees a navbar' do
      expect(page).to have_css('nav')

      within 'nav' do
        expect(page).to have_link('CONNECT WITH SPOTIFY')
        expect(page).to have_button('ABOUT')
      end
    end


    it 'sees an about section' do
      expect(page).to have_css('#about')
      within '#about' do
        expect(page).to have_content(
          'At parties, there is often one person who ends up being in charge of the music. What if everyone’s preferences could be taken into consideration by simply inviting one’s friends via a text message, from there, the music would then take care of itself'
        )
      end
    end
  end
end
