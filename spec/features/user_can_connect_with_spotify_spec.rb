# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'A user registers an account through Spotify' do
  describe 'As a visitor, when I go to the homepage' do
    describe 'and I click on connect with spotify' do
      it 'should connect to spotify by going through oauth' do
        visit '/'
        expect(page).to have_button('Connect With Spotify')
      end

      describe 'when I click on the register button' do
        describe 'and I sign in successfully on Spotify' do
          before :each do
            stub_oauth_connection
            mock_auth = OmniAuth.config.mock_auth[:spotify]
            Rails.application.env_config['omniauth.auth'] = mock_auth

            visit '/'
            within 'nav' do
              click_button 'Connect With Spotify'
            end
          end

          it 'should redirect me to the dashboard' do
            expect(current_path).to eq('/dashboard')
          end

          it 'the navigation bar should now include Logout' do
            expect(page).to have_content('Logout')
            expect(page).to_not have_content('Connect With Spotify')
          end

          it 'I get a flash message that I successfully created an account' do
            expect(page).to have_content('Logout')
            expect(page).to_not have_content('Connect With Spotify')

            message = 'You Have Successfully Connected With Spotify'

            expect(page).to have_content(message)
          end

          it 'I should now have an account in the system' do
            expect(User.count).to eq(1)
            expect(User.last.name).to eq('Fake Name')
          end
        end
      end
    end
  end
end
