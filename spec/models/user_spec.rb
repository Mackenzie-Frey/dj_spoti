# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:spotify_id).with_message("This Spotify account has already been registered with DJ Spoti") }

    it {
      should validate_length_of(:name)
        .is_at_least(1)
    }
  end
end
