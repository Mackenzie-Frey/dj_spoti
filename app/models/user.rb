# frozen_string_literal: true

# User Model. It has a spotify_id, name, access_token and refresh_token
class User < ApplicationRecord
  validates :spotify_id, uniqueness: true, presence: true
  validates :name, presence: true, length: { minimum: 1 }
end
