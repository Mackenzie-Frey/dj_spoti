require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit /' do
    describe 'and I scroll to the register/login section' do
      it 'I should see a register button' do
        visit '/'
        expect(page).to have_button("Register with Spotify")
      end
      describe 'when I click on the register button' do
        it 'I should be redirected to the spotify oauth' do
          visit '/'
          click_button "Register with Spotify"
          expect(current_path).to eq('/auth/spotify')
        end
        describe 'When I sign in successfully on Spotify' do
          before :each do
            Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:spotify]
          end

          it 'should redirect me to the dashboard' do
            visit '/'
            click_button "Register with Spotify"
            expect(current_path).to eq('/')
          end

          it 'the navigation bar should now include Logout' do
            visit '/'
            click_button "Register with Spotify"
            expect(page).to have_content("Logout")
            expect(page).to_not have_content("Login")
          end

          it 'I get a flash message that I successfully created an account' do
            visit '/'
            click_button "Register with Spotify"
            expect(page).to have_content("Logout")
            expect(page).to_not have_content("Login")

            expect(page).to have_content("You have successfully registered an account")
          end

          it 'I should now have an account in the system' do
            visit '/'
            click_button "Register with Spotify"
            expect(User.count).to eq(1)
            expect(User.last.name).to eq('Fake Name')
          end


        end
      end
    end
  end
end
