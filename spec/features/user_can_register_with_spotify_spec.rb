require 'rails_helper'

RSpec.feature 'A user registers an account through Spotify' do
  describe 'As a visitor, when I go to the homepage' do
    describe 'and I scroll to the register/login section' do
      it 'I should see a register button' do
        visit '/'
        expect(page).to have_button("Register with Spotify")
      end
      describe 'when I click on the register button' do

        describe 'and I sign in successfully on Spotify' do
          before :each do
            stub_oauth_registration
            Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:spotify]
            visit '/'
            click_button "Register with Spotify"
          end

          it 'should redirect me to the dashboard' do
            expect(current_path).to eq('/')
          end

          it 'the navigation bar should now include Logout' do

            expect(page).to have_content("Logout")
            expect(page).to_not have_content("Login")
          end

          it 'I get a flash message that I successfully created an account' do

            expect(page).to have_content("Logout")
            expect(page).to_not have_content("Login")

            expect(page).to have_content("You have successfully registered an account")
          end

          it 'I should now have an account in the system' do

            expect(User.count).to eq(1)
            expect(User.last.name).to eq('Fake Name')
          end
        end

        describe 'if my spotify account is already registered in the app' do
          before :each do
            stub_oauth_registration
            Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:spotify]
            # This is the same spotify_id from the stubbed_omniauth
            create(:user, spotify_id: "fakeId")

          end
          it 'I see an error message' do
            visit '/'
            click_button "Register with Spotify"

            expect(page).to have_content("Spotify has already been taken")
          end
        end
      end


    end
  end
end
