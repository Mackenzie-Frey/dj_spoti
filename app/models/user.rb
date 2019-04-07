# frozen_string_literal: true

# User Model. It has a spotify_id, name, access_token and refresh_token
class User < ApplicationRecord
  validates :spotify_id, presence: true,
            uniqueness: { message: "This Spotify account has already been registered with DJ Spoti"}
  validates :name, presence: true, length: { minimum: 1 }
  has_many :party_users
  has_many :parties, through: :party_users
end
