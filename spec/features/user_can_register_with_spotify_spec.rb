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
          it 'should redirect me to the dashboard' do
          end

          it 'the navigation bar should now include Logout' do
          end

          it 'I get a flash message that I successfully created an account' do
          end


        end
      end
    end
  end
end
