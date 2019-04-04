class User < ApplicationRecord
  validates :spotify_id, uniqueness: true, presence: true
  validates :name, presence: true, length: {minimum: 1}
end
